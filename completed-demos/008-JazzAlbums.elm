module JazzAlbums exposing (main)

import Html exposing (Html, div, h2, h3, i, img, li, text, ul)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)


---- CONSTANTS ----


baseUrl : String
baseUrl =
    "https://jazz-album-covers.surge.sh/images/"


type alias Rating =
    Int


unrated : Rating
unrated =
    0


liked : Rating
liked =
    1


disliked : Rating
disliked =
    2


type alias Id =
    Int


type alias Album =
    { id : Id
    , title : String
    , coverUrl : String
    , artist : String
    , rating : Rating
    }


albums : List Album
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


type alias Model =
    { albums : List Album }


initialModel : Model
initialModel =
    Model albums



---- UPDATE ----


updateRating : Rating -> Album -> Album
updateRating rating album =
    if album.rating == rating then
        { album | rating = unrated }
    else
        { album | rating = rating }


like : Album -> Album
like =
    updateRating liked


dislike : Album -> Album
dislike =
    updateRating disliked


updateAlbum : (Album -> Album) -> Id -> List Album -> List Album
updateAlbum updater id albums =
    List.map
        (\album ->
            if album.id == id then
                updater album
            else
                album
        )
        albums


type alias Msg =
    { type_ : String
    , id : Id
    }


update : Msg -> Model -> Model
update msg model =
    if msg.type_ == "LIKE" then
        { model | albums = updateAlbum like msg.id model.albums }
    else if msg.type_ == "DISLIKE" then
        { model | albums = updateAlbum dislike msg.id model.albums }
    else
        model



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "albums" ]
        [ viewAlbumList model.albums ]


viewAlbumList : List Album -> Html Msg
viewAlbumList albums =
    ul [ class "album-list" ]
        (List.map viewAlbum albums)


viewAlbum : Album -> Html Msg
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


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
