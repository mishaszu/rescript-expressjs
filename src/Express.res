type t

type middleware

module Response = {
  type t

  @send external send: t => unit = "send"
  @send external sendString: (t, string) => unit = "send"
  @send external sendFile: (t, string) => unit = "sendFile"
  @send external sendJson: (t, Js.Json.t) => unit = "json"
  @send external status: (t, int) => t = "status"
}

module Request = {
  type t

  @get external path: t => string = "path"
  @get external method: t => string = "method"
  @get external query: t => Js.Dict.t<string> = "query"
  @get external params: t => Js.Json.t = "params"
  @get external body: t => Js.Json.t = "body"
}

module Middleware = {
  type t
  type p<'a>

  type next<'a> = 'a => unit

  type callback = (Request.t, Response.t) => promise<unit>

  type callback3<'a> = (Request.t, Response.t, next<'a>) => promise<unit>

  type callbackFull<'e, 'a> = ('e, Request.t, Response.t, next<'a>) => promise<unit>
}

module Router = {
  type r

  @send external use: (r, Middleware.t) => unit = "use"
  @send external useWithPath: (r, string, Middleware.t) => unit = "use"
  @send external get: (r, string, Middleware.callback) => unit = "get"
  @send external getUse: (r, string, Middleware.t) => unit = "get"
  @send
  external useWithMiddleware: (r, Middleware.callback3<'a>, Middleware.callback) => unit = "use"
  @send external post: (r, string, Middleware.callback) => unit = "post"
  @send external postUse: (r, string, Middleware.t) => unit = "post"
  @send
  external postUseFull: (r, string, Middleware.callback, Middleware.callbackFull<'e, 'a>) => unit =
    "post"
  @send external put: (r, string, Middleware.callback) => unit = "put"

  @module("express") external make: unit => r = "Router"
}

module Methods = {
  @send external use: (t, Middleware.t) => unit = "use"
  @send external useWithPath: (t, string, Middleware.t) => unit = "use"
  @send
  external useWithMiddleware: (t, Middleware.callback3<'a>, Middleware.callback) => unit = "use"
  @send external useRouter: (t, string, Router.r) => unit = "use"
  @send external get: (t, string, Middleware.callback) => unit = "get"
  @send external getUse: (t, string, Middleware.t) => unit = "get"
  @send external post: (t, string, Middleware.callback) => unit = "post"
  @send external postUse: (t, string, Middleware.t) => unit = "post"
  @send
  external postUseFull: (t, string, Middleware.callback, Middleware.callbackFull<'e, 'a>) => unit =
    "post"
  @send external put: (t, string, Middleware.callback) => unit = "put"
}

@module external make: unit => t = "express"
@send external listen: (t, int, unit => unit) => unit = "listen"
