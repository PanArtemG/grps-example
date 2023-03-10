//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: todo.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// The todos service definition.
///
/// Usage: instantiate `Todos_TodoServiceClient`, then call methods of this protocol to make API calls.
internal protocol Todos_TodoServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Todos_TodoServiceClientInterceptorFactoryProtocol? { get }

  func fetchTodos(
    _ request: Todos_Empty,
    callOptions: CallOptions?
  ) -> UnaryCall<Todos_Empty, Todos_TodoList>

  func createTodo(
    _ request: Todos_Todo,
    callOptions: CallOptions?
  ) -> UnaryCall<Todos_Todo, Todos_Todo>

  func deleteTodo(
    _ request: Todos_TodoID,
    callOptions: CallOptions?
  ) -> UnaryCall<Todos_TodoID, Todos_Empty>

  func completeTodo(
    _ request: Todos_TodoID,
    callOptions: CallOptions?
  ) -> UnaryCall<Todos_TodoID, Todos_Todo>
}

extension Todos_TodoServiceClientProtocol {
  internal var serviceName: String {
    return "todos.TodoService"
  }

  /// Return a list of todos.
  ///
  /// - Parameters:
  ///   - request: Request to send to FetchTodos.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func fetchTodos(
    _ request: Todos_Empty,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Todos_Empty, Todos_TodoList> {
    return self.makeUnaryCall(
      path: "/todos.TodoService/FetchTodos",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeFetchTodosInterceptors() ?? []
    )
  }

  /// Create a new todo
  ///
  /// - Parameters:
  ///   - request: Request to send to CreateTodo.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func createTodo(
    _ request: Todos_Todo,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Todos_Todo, Todos_Todo> {
    return self.makeUnaryCall(
      path: "/todos.TodoService/CreateTodo",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCreateTodoInterceptors() ?? []
    )
  }

  /// Delete a todo
  ///
  /// - Parameters:
  ///   - request: Request to send to DeleteTodo.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func deleteTodo(
    _ request: Todos_TodoID,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Todos_TodoID, Todos_Empty> {
    return self.makeUnaryCall(
      path: "/todos.TodoService/DeleteTodo",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeDeleteTodoInterceptors() ?? []
    )
  }

  /// Toggle the completion of a todo
  ///
  /// - Parameters:
  ///   - request: Request to send to CompleteTodo.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func completeTodo(
    _ request: Todos_TodoID,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Todos_TodoID, Todos_Todo> {
    return self.makeUnaryCall(
      path: "/todos.TodoService/CompleteTodo",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCompleteTodoInterceptors() ?? []
    )
  }
}

internal protocol Todos_TodoServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'fetchTodos'.
  func makeFetchTodosInterceptors() -> [ClientInterceptor<Todos_Empty, Todos_TodoList>]

  /// - Returns: Interceptors to use when invoking 'createTodo'.
  func makeCreateTodoInterceptors() -> [ClientInterceptor<Todos_Todo, Todos_Todo>]

  /// - Returns: Interceptors to use when invoking 'deleteTodo'.
  func makeDeleteTodoInterceptors() -> [ClientInterceptor<Todos_TodoID, Todos_Empty>]

  /// - Returns: Interceptors to use when invoking 'completeTodo'.
  func makeCompleteTodoInterceptors() -> [ClientInterceptor<Todos_TodoID, Todos_Todo>]
}

internal final class Todos_TodoServiceClient: Todos_TodoServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Todos_TodoServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the todos.TodoService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Todos_TodoServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// The todos service definition.
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Todos_TodoServiceProvider: CallHandlerProvider {
  var interceptors: Todos_TodoServiceServerInterceptorFactoryProtocol? { get }

  /// Return a list of todos.
  func fetchTodos(request: Todos_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_TodoList>

  /// Create a new todo
  func createTodo(request: Todos_Todo, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_Todo>

  /// Delete a todo
  func deleteTodo(request: Todos_TodoID, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_Empty>

  /// Toggle the completion of a todo
  func completeTodo(request: Todos_TodoID, context: StatusOnlyCallContext) -> EventLoopFuture<Todos_Todo>
}

extension Todos_TodoServiceProvider {
  internal var serviceName: Substring { return "todos.TodoService" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "FetchTodos":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Todos_Empty>(),
        responseSerializer: ProtobufSerializer<Todos_TodoList>(),
        interceptors: self.interceptors?.makeFetchTodosInterceptors() ?? [],
        userFunction: self.fetchTodos(request:context:)
      )

    case "CreateTodo":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Todos_Todo>(),
        responseSerializer: ProtobufSerializer<Todos_Todo>(),
        interceptors: self.interceptors?.makeCreateTodoInterceptors() ?? [],
        userFunction: self.createTodo(request:context:)
      )

    case "DeleteTodo":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Todos_TodoID>(),
        responseSerializer: ProtobufSerializer<Todos_Empty>(),
        interceptors: self.interceptors?.makeDeleteTodoInterceptors() ?? [],
        userFunction: self.deleteTodo(request:context:)
      )

    case "CompleteTodo":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Todos_TodoID>(),
        responseSerializer: ProtobufSerializer<Todos_Todo>(),
        interceptors: self.interceptors?.makeCompleteTodoInterceptors() ?? [],
        userFunction: self.completeTodo(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Todos_TodoServiceServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'fetchTodos'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeFetchTodosInterceptors() -> [ServerInterceptor<Todos_Empty, Todos_TodoList>]

  /// - Returns: Interceptors to use when handling 'createTodo'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeCreateTodoInterceptors() -> [ServerInterceptor<Todos_Todo, Todos_Todo>]

  /// - Returns: Interceptors to use when handling 'deleteTodo'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeDeleteTodoInterceptors() -> [ServerInterceptor<Todos_TodoID, Todos_Empty>]

  /// - Returns: Interceptors to use when handling 'completeTodo'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeCompleteTodoInterceptors() -> [ServerInterceptor<Todos_TodoID, Todos_Todo>]
}
