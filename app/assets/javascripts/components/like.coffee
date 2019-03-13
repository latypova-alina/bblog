class Like extends Components.Base
  refs:
    likeItem: "a.like"

  config:
    newLikeUrl: "/api/v1/likes"

  initialize: ->
    @postId = @$el.data("id")

  bindings: ->
    @$refs.likeItem.click @_updatePostRating

  _updatePostRating: (event) =>
    event.preventDefault()

    $.ajax
      url: @config.newLikeUrl
      type: "POST"
      dataType: "json"
      data:
        { post_id: @postId }
      success: (response) =>
        @_updateLike()
        console.log("im here")

  _updateLike: () =>
    @$refs.likeItem.addClass("picked")

$ ->
  for $el of $(".js-like")
    new Like($el)