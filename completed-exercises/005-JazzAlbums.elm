module JazzAlbums exposing (main)

import Html exposing (div, h2, h3, i, img, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)


---- CONSTANTS ----


baseUrl =
    "https://jazz-album-covers.surge.sh/images/"



{--

STEP 1
======

You will likely want a constant for disliked similar to liked. Set it equal to 2.

--}


unrated =
    0


liked =
    1


disliked =
    2



---- MODEL ----


initialModel =
    { id = 1
    , title = "Kind of Blue"
    , coverUrl = baseUrl ++ "miles-davis-kind-of-blue.jpg"
    , artist = "Miles Davis"
    , rating = unrated
    }



---- UPDATE ----
{--

STEP 2
======

a. Handle a new "DISLIKE" message.
b. Reset the rating to unrated if the current rating matches the new rating.

--}


update msg model =
    if msg == "LIKE" then
        { model
            | rating =
                if model.rating == liked then
                    unrated
                else
                    liked
        }
    else if msg == "DISLIKE" then
        { model
            | rating =
                if model.rating == disliked then
                    unrated
                else
                    disliked
        }
    else
        model



---- VIEW ----


view model =
    div [ class "albums" ]
        [ viewAlbum model ]



{--

STEP 3
======

Create a similar dislike icon. You'll want to use fa-thumbs-down classes
instead of fa-thumbs-up where appropriate. Make sure you dispatch a "DISLIKE"
message when the user clicks on the dislike icon.

--}


viewAlbum album =
    div [ class "album" ]
        [ img [ src album.coverUrl ] []
        , div [ class "album__rating" ]
            [ i
                [ class "far fa-lg fa-thumbs-up"
                , classList [ ( "fa-thumbs-up--selected", album.rating == liked ) ]
                , onClick "LIKE"
                ]
                []
            , i
                [ class "far fa-lg fa-thumbs-down"
                , classList [ ( "fa-thumbs-down--selected", album.rating == disliked ) ]
                , onClick "DISLIKE"
                ]
                []
            ]
        , h2 [ class "album__title" ]
            [ text album.title ]
        , h3 [ class "album__artist" ]
            [ text album.artist ]
        ]



---- PROGRAM ----


main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
