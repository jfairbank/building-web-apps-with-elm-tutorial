module JazzAlbums exposing (main)

import Html exposing (div, h2, h3, i, img, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)


---- CONSTANTS ----


baseUrl =
    "https://jazz-album-covers.surge.sh/images/"


unrated =
    0


liked =
    1



---- MODEL ----


initialModel =
    { id = 1
    , title = "Kind of Blue"
    , coverUrl = baseUrl ++ "miles-davis-kind-of-blue.jpg"
    , artist = "Miles Davis"
    , rating = unrated
    }



---- UPDATE ----


update msg model =
    if msg == "LIKE" then
        { model | rating = liked }
    else
        model



---- VIEW ----


view model =
    div [ class "albums" ]
        [ viewAlbum model ]


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
