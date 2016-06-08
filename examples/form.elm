import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String exposing (..)
import Char exposing (..)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }

model : Model
model =
  Model "" "" ""

type Msg
  = Name String
  | Password String
  | PasswordAgain String

update : Msg -> Model -> Model
update action model =
  case action of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain passwordAgain ->
      { model | passwordAgain = passwordAgain }

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name] []
    , input [ type' "password", placeholder "Password", onInput Password] []
    , input [ type' "password", placeholder "Re-enter password", onInput PasswordAgain] []
    , viewValidation model
    , validationLength model
    , validationUpper model
    , validationLower model
    ]

viewValidation : Model -> Html Msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]

validationLength : Model -> Html Msg
validationLength model =
  let
    (color, message) =
      if String.length model.password > 8 then
        ("green", "OK")
      else
        ("red", "Passwords must be at least 8 letters!")
  in
    div [ style [("color", color)] ] [ text message ]

validationUpper : Model -> Html Msg
validationUpper model =
  let
    (color, message) =
      if String.any isUpper model.password then
        ("green", "OK")
      else
        ("red", "Password must contain uppercase!")
  in
    div [ style [("color", color)] ] [ text message ]

validationLower : Model -> Html Msg
validationLower model =
  let
    (color, message) =
      if String.any isLower model.password then
        ("green", "OK")
      else
        ("red", "Password must contain lowercase!")
  in
    div [ style [("color", color)] ] [ text message ]
