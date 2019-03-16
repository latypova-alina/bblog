class Like extends Components.Base
  refs:
    likeItem: "a.like"

  config:
    newLikeUrl: "/api/v1/posts/:post_id/likes"

  initialize: ->
    @postId = @$el.data("post_id")

  bindings: ->
    @$refs.likeItem.click @_updatePostRating

  _updatePostRating: (event) =>
    event.preventDefault()

    $.ajax
      url: @config.newLikeUrl.replace(":post_id", @postId)
      type: "POST"
      dataType: "json"
      success: (response) =>
        @_updateLike()

  _updateLike: () =>
    @$refs.likeItem.addClass("picked")

$ ->
  new Like($(".js-like"))
