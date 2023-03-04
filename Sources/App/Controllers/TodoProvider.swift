/// Copyright (c) 2022 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import Foundation
import GRPC
import Vapor
import Fluent



class TodoProvider: Todos_TodoServiceProvider {
  var interceptors: Todos_TodoServiceServerInterceptorFactoryProtocol?
  var app: Application
  
  init(_ app: Application) {
    self.app = app
  }
  
  func fetchTodos(request: Todos_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_TodoList> {
    let todos = Todo.query(on: app.db(.psql)).all().map { todos -> Todos_TodoList in
      var listToReturn = Todos_TodoList()
      for td in todos {
        listToReturn.todos.append(Todos_Todo(td))
      }
      return listToReturn
    }
    
    return todos
  }
  
  func createTodo(request: Todos_Todo, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_Todo> {
    let todo = Todo(request)
    return todo.save(on: app.db(.psql)).map {
      Todos_Todo(todo)
    }
  }
  
  func deleteTodo(request: Todos_TodoID, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_Empty> {
    guard let uuid = UUID(uuidString: request.todoID) else {
      context.responseStatus.code = .invalidArgument
      return context.eventLoop.makeFailedFuture(GRPCStatus(code: .invalidArgument, message: "Invalid TodoID"))
    }
    return Todo.find(uuid, on: app.db(.psql)).unwrap(or: Abort(.notFound)).flatMap { [self] todo in
      todo.delete(on: app.db(.psql)).transform(to: context.eventLoop.makeSucceededFuture(Todos_Empty()))
    }
  }
  
  func completeTodo(request: Todos_TodoID, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_Todo> {
    guard let uuid = UUID(uuidString: request.todoID) else {
      context.responseStatus.code = .invalidArgument
      return context.eventLoop.makeFailedFuture(GRPCStatus(code: .invalidArgument, message: "Invalid TodoID"))
    }
    return Todo.find(uuid, on: app.db(.psql)).unwrap(or: Abort(.notFound)).flatMap { [self] todo in
      todo.completed = !todo.completed
      return todo.update(on: app.db(.psql)).transform(to: context.eventLoop.makeSucceededFuture(Todos_Todo(todo)))
    }
  }
  
  
}
