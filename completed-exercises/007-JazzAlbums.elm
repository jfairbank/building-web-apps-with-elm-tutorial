module JazzAlbums exposing (main)

import Html exposing (div, h2, h3, i, img, li, text, ul)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)


---- CONSTANTS ----


baseUrl =
    "https://jazz-album-covers.surge.sh/images/"


unrated =
    0


liked =
    1


disliked =
    2


albums =
    [ { id = 1
      , title = "Kind of Blue"
      , coverUrl = baseUrl ++ "miles-davis-kind-of-blue.jpg"
      , artist = "Miles Davis"
      , rating = unrated
      }
    , { id = 2
      , title = "A Love Supreme"
      , coverUrl = baseUrl ++ "john-coltrane-a-love-supreme.jpg"
      , artist = "John Coltrane"
      , rating = unrated
      }
    , { id = 3
      , title = "Out to Lunch"
      , coverUrl = baseUrl ++ "eric-dolphy-out-to-lunch.jpg"
      , artist = "Eric Dolphy"
      , rating = unrated
      }
    , { id = 4
      , title = "Blue Train"
      , coverUrl = baseUrl ++ "john-coltrane-blue-train.jpg"
      , artist = "John Coltrane"
      , rating = unrated
      }
    ]



---- MODEL ----


initialModel =
    { albums = albums }



---- UPDATE ----


updateRating rating album =
    if album.rating == rating then
        { album | rating = unrated }
    else
        { album | rating = rating }



{--

STEP 1
======

Create a similar partially applied dislike function for disliking albums.

--}


like =
    updateRating liked


dislike =
    updateRating disliked



{--

STEP 2
======

a. Extract out the `List.map` portion into a helper function called
   `updateAlbum`. It should accept a function that updates an album, the id of
   the album to update, and the list of albums as arguments. The function
   should return a new list of albums.

   You will still use the same if-else structure inside the `List.map`
   anonymous function, but you will use the function argument instead of the
   hardcoded `like` function to change the album.

   Here is an example of calling the final function (hint):

       updateAlbum like msg.id model.albums

b. Modify the `update` function to use `updateAlbum` for the `LIKE` message.

c. Add back a handler in the `update` function for the `DISLIKE` message. Use the
   `updateAlbum` and `dislike` helpers.

--}


updateAlbum updater id albums =
    List.map
        (\album ->
            if album.id == id then
                updater album
            else
                album
        )
        albums


update msg model =
    if msg.type_ == "LIKE" then
        { model | albums = updateAlbum like msg.id model.albums }
    else if msg.type_ == "DISLIKE" then
        { model | albums = updateAlbum dislike msg.id model.albums }
    else
        model



---- VIEW ----


view model =
    div [ class "albums" ]
        [ viewAlbumList model.albums ]


viewAlbumList albums =
    ul [ class "album-list" ]
        (List.map viewAlbum albums)



{--

STEP 3
======

Add back the onClick handler to the dislike icon with a new DISLIKE message
that is similar to the LIKE record message.

--}


viewAlbum album =
    li []
        [ div [ class "album" ]
            [ img [ src album.coverUrl ] []
            , div [ class "album__rating" ]
                [ i
                    [ class "far fa-lg fa-thumbs-up"
                    , classList [ ( "fa-thumbs-up--selected", album.rating == liked ) ]
                    , onClick { type_ = "LIKE", id = album.id }
                    ]
                    []
                , i
                    [ class "far fa-lg fa-thumbs-down"
                    , classList [ ( "fa-thumbs-down--selected", album.rating == disliked ) ]
                    , onClick { type_ = "DISLIKE", id = album.id }
                    ]
                    []
                ]
            , h2 [ class "album__title" ]
                [ text album.title ]
            , h3 [ class "album__artist" ]
                [ text album.artist ]
            ]
        ]



---- PROGRAM ----


main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
