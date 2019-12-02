class Like extends Components.Base
  refs:
    likeItem: "a.like"
    likesCount: "li.likes-count"

  config:
    newLikeUrl: "/api/v1/posts/:post_id/likes"
    deleteLikeUrl: "/api/v1/posts/:post_id/likes/:id"

  initialize: ->
    @postId = @$el.data("post_id")
    @likeId = @$el.data("like_id")
    @likesCount = @$el.data("likes_count")

  bindings: ->
    @$refs.likeItem.click @_updatePostRating

  _updatePostRating: (event) =>
    event.preventDefault()

    if @$refs.likeItem[0].classList.contains("picked")
      @_deleteLike()
    else
      @_createLike()

  _updateRating: (response)=>
    @$refs.likesCount.text(response.data.attributes.likes_count)

  _deleteLike: () =>
    $.ajax
        url: @config.deleteLikeUrl.replace(":post_id", @postId).replace(":id", @likeId)
        type: "DELETE"
        dataType: "json"
        success: (response) =>
          @_markAsUnliked()
          @_updateRating(response)

  _createLike: () =>
    $.ajax
      url: @config.newLikeUrl.replace(":post_id", @postId)
      type: "POST"
      dataType: "json"
      success: (response) =>
        @_markAsLiked()
        @_updateRating(response)

  _markAsLiked: () =>
    @$refs.likeItem.addClass("picked")

  _markAsUnliked: () =>
    @$refs.likeItem.removeClass("picked")

$ ->
  new Like($(".js-like"))
