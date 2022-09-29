import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:move37/network/networkExceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://35.234.72.152:8000/";
  Future<dynamic> getDataSets() async {
    return {
      "imdb": [
        {
          "id": "1",
          "text":
              "This movie was great, and I suggest that you go see it before you judge."
        },
        {
          "id": "2",
          "text":
              "Actor turned director Bill Paxton follows up his promising debut, the Gothic-horror Frailty, with this family friendly sports drama about the 1913 U.S."
        },
        {
          "id": "3",
          "text":
              "I saw this film in a sneak preview, and it is delightful. The cinematography is unusually creative, the acting is good, and the story is fabulous"
        },
        {
          "id": "4",
          "text":
              "Bill Paxton has taken the true story of the 1913 US golf open and made a film that is about much more than an extra-ordinary game of golf."
        },
        {
          "id": "5",
          "text":
              "I felt this film did have many good qualities. The cinematography was certainly different exposing the stage aspect of the set and story."
        }
      ],
      "tweepfake": [
        {
          "id": "1",
          "text":
              "justin timberlake really one of the goats if you think about it"
        },
        {"id": "2", "text": "I Wanna See Some Rainbows Out There Boys"},
        {
          "id": "3",
          "text":
              "Spent a great afternoon in Rohtak. Haryana has witnessed transformative changes in the last five years. Corruption and nepotism have disappeared."
        },
        {"id": "4", "text": "getting a 4k monitor so i can make posts"},
        {
          "id": "5",
          "text":
              "Once a product has FDA approval, the legislation would allow its sale in San Francisco again"
        }
      ],
      "newsgroup": [
        {
          "id": "1",
          "text": "IM WEARING A DURAG AND YALL CANT STOP ME. L8R H8RS"
        },
        {
          "id": "2",
          "text":
              "Original sentence: @nabrathhhh Broken code can be devastating I think you're making light of what engineers do...Imagine some code at Twitter crashes and brings down the entire site for two hours and you aren't able to send your corny tweets anymore"
        },
        {
          "id": "3",
          "text": "We are the possible work together took for the programme."
        },
        {
          "id": "4",
          "text": "In the programme of Madheram for the coming our country."
        },
        {
          "id": "5",
          "text":
              "So you want to know why I only allow 1 nude.com post per month? Because ITS MY RIGHT ALONE"
        }
      ],
    };
    // var responseJson;
    // try {
    //   final response = await http.get(
    //     Uri.parse("${_baseUrl}Datasets"),
    //   );
    //   responseJson = _returnResponse(response);
    // } on SocketException {
    //   print('No net');
    //   throw FetchDataException('No Internet connection');
    // }
    // return responseJson;
  }

  Future<dynamic> getModelResponse(
      int? sentenceId, String sentence, String dataset) async {
    if (sentenceId != -1) {
      if (preRenderedModelResponse[dataset][sentenceId] != null) {
        return [preRenderedModelResponse[dataset][sentenceId]['result']];
      }
      throw FetchDataException('No Error Occured');
    }
    var responseJson;
    try {
      final response = await http.get(Uri.parse(
          "${_baseUrl}Prediction?input_sentence=$sentence&dataset_type=$dataset"));
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

Map preRenderedModelResponse = {
  "imdb": [
    {
      "id": "1",
      "result": {
        "input":
            "This movie was great, and I suggest that you go see it before you judge",
        "masked_index": [13],
        "orig_contrast_prob": 0.1354914754629135,
        "orig_pred": "Human",
        "contrast_pred": "Bot",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "This movie was great, and I suggest that you go see it before sex.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8316957354545593,
            "minimality": 0.125,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "This movie was great, and I suggest that you go see it before.@essilannl",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7922714948654175,
            "minimality": 0.1875,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "This  project was great, and I suggest that you go see it before the #IdgeSecretary",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9822301864624023,
            "minimality": 0.25,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "This movie was great, and I suggest that you go see it before you watch it before..",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8146771788597107,
            "minimality": 0.25,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "This  is great, and I suggest that you go see it to your forebodies",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.650402307510376,
            "minimality": 0.3125,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "This movie was great, and I suggest that you go see it before you got to it??",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9240555763244629,
            "minimality": 0.3125,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "This movie was great, and I suggest that you go see it before you get your hair.<unk>n",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5288694500923157,
            "minimality": 0.3125,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "This  is great, and I suggest that you go see it #FearDayDay #GrilDay_Stop",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8749104142189026,
            "minimality": 0.375,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "This  game was great, and I suggest that you go see it before your to do it before youre shit",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9223226308822632,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "This movie was great, and I suggest that you go see it before you can watch this movie!! fucker?",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8979234099388123,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "This movie was great, and I suggest that you go see it before.<unk>r<unk>n<unk>tJudge",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7045900821685791,
            "minimality": 0.6875,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 43.244515895843506,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "This movie was great, and I suggest that you go see it before you <unk>joke><unk>cook_up_heart_st<unk>r<unk>n<unk>t",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5489746928215027,
            "minimality": 1.125,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 43.244515895843506,
            "error": false
          }
        ]
      }
    },
    {
      "id": "2",
      "result": {
        "input":
            "Actor turned director Bill Paxton follows up his promising debut, the Gothic-horror Frailty, with this family friendly sports drama about the 1913 U.S.",
        "masked_index": [21],
        "orig_contrast_prob": 0.003524565137922764,
        "orig_pred": "Positive",
        "contrast_pred": "Negative",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the Gothic-horror Frailty, with this family friendly sports drama about the film U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.5671665668487549,
            "minimality": 0.037037037037037035,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the Gothic-horror Frailty, with this family friendly sports drama about the film of The U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.983756422996521,
            "minimality": 0.1111111111111111,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the  storyline with his son-horror Frailty, with this family friendly sports drama about the legendary U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.6702982187271118,
            "minimality": 0.18518518518518517,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the  hit of the stars-horror Frailty, with this family friendly sports drama about the U.S. U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.6472444534301758,
            "minimality": 0.18518518518518517,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the Gothic-horror Frailty, with this family friendly sports drama about the play-packed drama about the U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9891740083694458,
            "minimality": 0.2222222222222222,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the  new reality show-horror -torro-yomy, with this family friendly sports drama about the upcoming U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.7454741597175598,
            "minimality": 0.25925925925925924,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "Actor turned director Bill Pa. He follows up his promising debut, the game-horror game, with this family friendly sports team about the big picture...",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.99598628282547,
            "minimality": 0.2962962962962963,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "Actor turned director Bill Pa. He follows up his promising debut, the game-horrord, with this family friendly sports team to watch about the sport...",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9987245202064514,
            "minimality": 0.37037037037037035,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the  \"Pixton-horror  of ay, with this family friendly sports drama about the world. We do it with the U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9474758505821228,
            "minimality": 0.4074074074074074,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the  “The Great Sky-horror ” and the thorn-powdery, with this family friendly sports drama about the world of the U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8123611211776733,
            "minimality": 0.48148148148148145,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the  title of a show of this special series-horror sy, with this family friendly sports drama about the North Shore and the U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.5891244411468506,
            "minimality": 0.48148148148148145,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "Actor turned director Bill Pa. He follows up his promising debut, the game-horror and the game, with this family friendly sports and sports world that is all about the best...,..",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8881681561470032,
            "minimality": 0.5925925925925926,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "Actor turned director Bill Pa. He follows up his promising debut, the game-horror game, with this family friendly sports legend. The slick game is about the real world. g! -.....",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.5767967700958252,
            "minimality": 0.6296296296296297,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "Actor turned director Bill Paxton follows up his promising debut, the  new --the Star Trek series starring acclaimed actress-horror Frailty, with this family friendly sports drama about the classic, with no nonsense or dangers of the U.S.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9969147443771362,
            "minimality": 0.6296296296296297,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "Actor turned director Bill Pa. He follows up his promising debut, the game-horrora, with this family friendly sports game game based on a few little ideas about the game, and it's vs...",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9736915826797485,
            "minimality": 0.7407407407407407,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 353.51808619499207,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "Actor turned director Bill Pa. He follows up his promising debut, the game-horror - the best sports league, with this family friendly sports ball. He has no clue about the id..... ), o.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9733441472053528,
            "minimality": 0.7407407407407407,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 353.51808619499207,
            "error": false
          }
        ]
      }
    },
    {
      "id": "3",
      "result": {
        "input":
            "I saw this film in a sneak preview, and it is delightful. The cinematography is unusually creative, the acting is good, and the story is fabulous.",
        "masked_index": [3, 6, 10, 12, 14, 24],
        "orig_contrast_prob": 0.0008213201072067022,
        "orig_pred": "Positive",
        "contrast_pred": "Negative",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "I saw this  post in a  different way, and it is  a good thing. The  story is  very creative, the acting is good, and the story is very good.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8225886821746826,
            "minimality": 0.3225806451612903,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "I saw this  book in a sneak  peek in my eyes. The story is fantastic, and it is delightful. The acting is unusually creative, the acting is good, and the story is fabulous.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8987666368484497,
            "minimality": 0.3548387096774194,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "I saw this  film in a  film, and it is  just beautiful. The  story is  beautiful and creative, the acting is good, and the story is good. The character is fantastic.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8403288722038269,
            "minimality": 0.41935483870967744,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "I saw this  movie. The story is not good in a  short time, and it is  interesting. The  acting is  well creative, the acting is good, and the story is very beautiful.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9637808799743652,
            "minimality": 0.45161290322580644,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "I saw this  story in a  way I could never get a lot of things, and it is  great. The  story is  incredibly creative, the acting is good, and the story is good.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.5985845327377319,
            "minimality": 0.45161290322580644,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "I saw this  story based in a  lot of fun, and it is  a lot like if you enact it. The  film is  very creative, the acting is good, and the story is really entertaining.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.971589982509613,
            "minimality": 0.5161290322580645,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "I saw this  book in a  book, and it is  quite enjoyable. The  story is  very creative, the acting is good, and the story is so good. It is great. There is something really interesting.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8724634051322937,
            "minimality": 0.6129032258064516,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "I saw this  image in a  movie, but its too dark, and it is  the remarkable one. The  story is  very creative, the acting is good, and the story is a little too harsh. It was really good.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8572017550468445,
            "minimality": 0.6774193548387096,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "I saw this  thing in a  similar way. I love it, and it is  really nice to listen to the scream. The  story is  well-crafted and the narrative is very creative, the acting is good, and the story is pretty good.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8568715453147888,
            "minimality": 0.8064516129032258,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "I saw this  product in a  lot, and it is  good. The  story is  not always creative, the acting is good, and the story is well worth it. I do this. Not to mention the sound. The film is not too great.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8250475525856018,
            "minimality": 0.8709677419354839,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "I saw this  as a movie in a  similar way, and it is  really good. The  acting is  very creative, the acting is good, and the story is good and enjoyable. I can't believe the film is very important. It is incredibly slick and I agree that the story is too well.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.688040554523468,
            "minimality": 1.1612903225806452,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 16,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 17,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 18,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 19,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 20,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 21,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 22,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 23,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 24,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 25,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          },
          {
            "idx": 26,
            "edited_input":
                "I saw this song and threw it in a movie, with the original characters to write. I love these songs! They look nice - the story looks fab! The story is very good & creative. Hopefully it works out well. The script is awesome!! I would have liked this story so far away. It is the same for my book of work. And, it is wonderful. Thank you!!!<unk> The movie is really cool and I know this is a story. But the movie has gone great in the world of the show '..cct show with ply. the song was too slow to show it, and it is",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9945968389511108,
            "minimality": 3.5806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 144.89779114723206,
            "error": false
          }
        ]
      }
    },
    {
      "id": "4",
      "result": {
        "input":
            "Bill Paxton has taken the true story of the 1913 US golf open and made a film that is about much more than an extra-ordinary game of golf.",
        "masked_index": [1, 9, 12, 16, 24],
        "orig_contrast_prob": 0.016211804002523422,
        "orig_pred": "Positive",
        "contrast_pred": "Negative",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "Bill Paul has taken the true story of the  US US golf  world and made a point that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8811737895011902,
            "minimality": 0.12903225806451613,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "Bill Pagel has taken the true story of the  iconic US golf  game and made a decision that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.7943273186683655,
            "minimality": 0.12903225806451613,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "Bill Pagan has taken the true story of the Open at the US golf open and made a film that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9446990489959717,
            "minimality": 0.12903225806451613,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "Bill Paxton has taken the true story of the 2017 US Open Open US golf open and made a film that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.6118919253349304,
            "minimality": 0.12903225806451613,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "Bill Paas has taken the true story of the  world over the US golf  market and made a decision that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9876484870910645,
            "minimality": 0.1935483870967742,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "Bill Payton has taken the true story of the US Open Championship in the US golf open and made a film that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.805540144443512,
            "minimality": 0.1935483870967742,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "Bill Paddington has taken the true story of the US Open Open at the13 US golf open and made a film that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.6189679503440857,
            "minimality": 0.1935483870967742,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "Bill Patel has taken the true story of the  sport of golf at US golf  tournaments and made a history that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.679878294467926,
            "minimality": 0.22580645161290322,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "Bill Papel has taken the true story of the  great US golf  course at the golf course and made a story that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9744760990142822,
            "minimality": 0.25806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "Bill Paxton has taken the true story of the  US golfers, his US golf ing legend, and made a story that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.7236827611923218,
            "minimality": 0.25806451612903225,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "Bill  Clinton has taken the true story of the  king and made a  decision that is about much more than an extra-interest game of that character.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9979281425476074,
            "minimality": 0.2903225806451613,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "Bill  McCorby has taken the true story of the  game and made a  video game that is about much more than an extra-comfortable game of action.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.7988338470458984,
            "minimality": 0.2903225806451613,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "Bill Paxton has taken the true story of the  realism of the US golf ing world and made a worldly cult golf game that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.7097458839416504,
            "minimality": 0.2903225806451613,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "Bill  Clinton has taken the true story of the  game of ice hockey and made a  video game that is about much more than an extra-a game of the game.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9948318004608154,
            "minimality": 0.3225806451612903,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "Bill e has taken the true story of the  day off and made a  decision that is about much more than an extra-so-game game of character.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9900122880935669,
            "minimality": 0.3225806451612903,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "Bill  Bill. Bill has taken the true story of the  game and made a  game that is about much more than an extra-spaced game of play.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9854671955108643,
            "minimality": 0.3225806451612903,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 16,
            "edited_input":
                "Bill , he has taken the true story of the  movie and made a  movie that is about much more than an extra-game game of action versus.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.7381172180175781,
            "minimality": 0.3225806451612903,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 17,
            "edited_input":
                "Bill  Bill has taken the true story of the  game in the first place, and made a  game that is about much more than an extra-special game of the game.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9913684725761414,
            "minimality": 0.3548387096774194,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 18,
            "edited_input":
                "Bill Payton has taken the true story of the  golf course on the US golf  course in the country and made a real story that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9903519749641418,
            "minimality": 0.3548387096774194,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 19,
            "edited_input":
                "Bill  Gates has taken the true story of the  game and made a  little more complicated story that is about much more than an extra-play game of the game.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9884886145591736,
            "minimality": 0.3870967741935484,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 20,
            "edited_input":
                "Bill  M. Brum has taken the true story of the  game, and made a  game of games that is about much more than an extra-world game of fantasy game.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9800547361373901,
            "minimality": 0.3870967741935484,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 21,
            "edited_input":
                "Bill ead has taken the true story of the  game and made a  story based on a real story that is about much more than an extra-bob game of the.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9578055143356323,
            "minimality": 0.3870967741935484,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 22,
            "edited_input":
                "Bill  Taylor has taken the true story of the  game and made a  swatch that isn't something that is about much more than an extra-featalic game of play...",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.7167186737060547,
            "minimality": 0.41935483870967744,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 23,
            "edited_input":
                "Bill  Ansel, who has taken the true story of the  game, and made a  play of game-games that is about much more than an extra-play game of play.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.950529158115387,
            "minimality": 0.45161290322580644,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 24,
            "edited_input":
                "Bill Pamela has taken the true story of the  big golf course in the US golf  course. In fact, Bill Pamel and made a name that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9845766425132751,
            "minimality": 0.45161290322580644,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 25,
            "edited_input":
                "Bill Paver has taken the true story of the  game... but he has reacted to it at a cult of the US golf er and made a choice that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9978690147399902,
            "minimality": 0.5161290322580645,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 26,
            "edited_input":
                "Bill  G. Murray has taken the true story of the  story and made a  little different that is about much more than an extra-play game of play on that one. <unk> .",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9984435439109802,
            "minimality": 0.5483870967741935,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 27,
            "edited_input":
                "Bill Pagliari has taken the true story of the  US Open Golf Tournament and is back to normal. Bill Pagliglias is a great player, who plays w-t in the US golf  world and made a game that is about much more than an extra-ordinary game of golf.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9371557831764221,
            "minimality": 0.8709677419354839,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          },
          {
            "idx": 28,
            "edited_input":
                "Bill Paul has taken the true story of the  golfer playing US golf  tournament and made a great selection of cards for golf. Bill Paul, who has written a blog for several years, said the golf tournament of 2010. Pamela, based in New York City, has created eagles golfing to create enthralled game and mastered he’s omis king.. The ball was filmed by nevada. In that event, the lion is now the only real golf course in america. I will have gallons of water. This is the first time that’ saga. He is in the same business and",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9996521472930908,
            "minimality": 3.064516129032258,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 98.66275191307068,
            "error": false
          }
        ]
      }
    },
    {
      "id": "5",
      "result": {
        "input":
            "I felt this film did have many good qualities. The cinematography was certainly different exposing the stage aspect of the set and story.",
        "masked_index": [3, 10],
        "orig_contrast_prob": 0.0020645828917622566,
        "orig_pred": "Positive",
        "contrast_pred": "Negative",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "I felt this  label but it did have many good qualities. The stage was certainly different exposing the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9782178997993469,
            "minimality": 0.16,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "I felt this  setting I felt I found that it did show well. The setting did have many good qualities. The setting was certainly different exposing the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9991268515586853,
            "minimality": 0.56,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "I felt this  a little good. I thought I had n the set set but it did have many good qualities. The set sets was certainly different exposing the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9898694157600403,
            "minimality": 0.64,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "I felt this set did have many good characters on the stage. The set was very different and different. I was amazed when I had s the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9629035592079163,
            "minimality": 0.68,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "I felt this set did have many good characters on the stage. The set was very different and different. I was amazed when I had s the stage because of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.8734114766120911,
            "minimality": 0.72,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "I felt this set did have many good characters on the stage. The set was very different and different. I was amazed when I had s the stage at the end of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9974186420440674,
            "minimality": 0.8,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "I felt this set did have many good characters on the stage. The set was very different and different. I was amazed when I had s the stage, the characters of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9915143251419067,
            "minimality": 0.8,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "I felt this set did have many good characters on the stage. The set was very different and different. I was amazed when I had s the stage. I thought it was important to write about the character of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.6636636853218079,
            "minimality": 1.12,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was certainly different exposing the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.999509334564209,
            "minimality": 1.6,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was quite different exposing the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9995348453521729,
            "minimality": 1.64,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "I felt this, and the setting is fantastic. I hoped the set to did have many good characters. The ending. This piece was quite very different and very different, but it was a different one. The set did have many different pieces but not. the characters the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9995267391204834,
            "minimality": 1.68,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was quite different from the stage to the rest of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9997163414955139,
            "minimality": 1.8,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was incredibly different and different from the different exposing the stage aspect of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9997394680976868,
            "minimality": 1.84,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was a different story of each person and the stage and all of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9997722506523132,
            "minimality": 1.92,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was pretty much different as I imagined the stage that was part of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9996408224105835,
            "minimality": 1.92,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was very different, not so much that it was so well done. I like the stage and film of the set and story.",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9994827508926392,
            "minimality": 2.24,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 16,
            "edited_input":
                "I felt this  character and acted well well, the premise was in it. The setting did have many good  things it was actually very good and fun. The  setting was  very different , with Both the stage stage and the concept.. This was very very different to that the stage stage, as a very o different! I was just able ; so the setting was completely different. I felt m so and felt I had to get an idea. the main was  very distinct. but i still was pretty great, it did all well.. And it  the series has so. it really.,. of the character but",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9996962547302246,
            "minimality": 4.2,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 17,
            "edited_input":
                "I felt this  character did have many good qualities. The tone was very positive and overall presentation was excellent. The film is good and the setting was great and it was really good. I feel it deserved but it certainly did. Nevertheless the show is a nice touch. It did make me think. This was incredibly enjoyable and, and but the set was pretty impressive and was so good!... the concept really was well, but very different. We were scou but I was confident I  was the same style in character.. But. the stage- was incredible in Both and this setting, however, it very re very very",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9968568086624146,
            "minimality": 4.2,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 18,
            "edited_input":
                "I felt this film did have many good qualities. The plot in the end was so subtle, but it was different because I had a strong show which was very positive. Throughout this film the film was quite different and the production was amazing. The film is not very impressive enough. Overall I think that this movie has starred more and more believable character. I would love to see this movies film. It was enlightening the arc in defining and influenced this and its ralistic aspect. However, it really is the same film, which is very interesting. There are certain certain, the story is different. And it was certainly different",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9949146509170532,
            "minimality": 4.2,
            "num_edit_rounds": 1,
            "mask_frac": 0.10312500000000001,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 19,
            "edited_input":
                "I felt this  set is great and there was many excellent qualities that the setting is very well and the set design. It was one very different, it y gave a different story and that it it was very uplifting. The characters clearly did quite well. In the story was not quite different. I really felt that I was confident that this concept was well good quality. However I didn only feel in it when.. it didn't, o'man was so well, the film was quite rambié. ) I am so impressed, this set was d. on the label label. This. did have many good",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9995173215866089,
            "minimality": 4.24,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 20,
            "edited_input":
                "I felt this set did have many good characters on the stage. The set was very different and different. I was amazed when I had s the stage i thought the set was a different set. All the things I did was feel like s the stage scene and the end effects and character elements. I was amazed at the quality and humour at how the tone of the scenes. There was plenty to see in the main character character and story. The overall character was great as the setting played an outstanding role. It was definitely the first set to feature ten characters and characters. - the style and tone were fantastic.. in this book the",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.6783555746078491,
            "minimality": 4.32,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 21,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was all the different and they are different and the set was different from the stage to the stage. I am also proud to have a great time with the actors. The scene is very very different - Both the scene and stage stage and even the tone, style, and costumes are fantastic. We enjoyed the story, the film was very much different. What was the most important part was",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9994404911994934,
            "minimality": 4.36,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          },
          {
            "idx": 22,
            "edited_input":
                "I felt this story. It was a very different. The scene was quite different but I think the setting was rather, but it was in really much. However they were really different and so it did have many good set. The show and film was very different but the production was pretty different and so the audience was quite different but I think this film was really quite exciting and was incredibly a little different. A few of the other actors fought in the role in Both roles. The stage was very different as the set were in ruins and the actors and actors were very much different – and with it they were always so different to each",
            "new_pred": "Negative",
            "orig_label": "Positive",
            "new_contrast_prob_pred": 0.9994750618934631,
            "minimality": 4.4,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 327.0610980987549,
            "error": false
          }
        ]
      }
    }
  ],
  "newsgroup": [
    {
      "id": "1",
      "result": {
        "input": "IM WEARING A DURAG AND YALL CANT STOP ME. L8R H8RS",
        "masked_index": [3],
        "orig_contrast_prob": 0.027432817965745926,
        "orig_pred": "Rec",
        "contrast_pred": "Comp",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "IM WEARING A DONE, WELCOMES AND YALL CANT STOP ME. L8R H8RS",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5117062926292419,
            "minimality": 0.25,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "IM WEARING A  COMING AND YES TO CANT STOP ME. L.R H. C",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9783535599708557,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "IM WEARING A  HARD AND YES CANT STOP ME. LOSTR HUD I S",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9672803282737732,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "IM WEARING A  DAY AND YELEL HARD CANT STOP ME. L.RR H...",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.8022277355194092,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "IM WEARING A SCHOOL AND YUMY LOOK CANT STOP ME. L.E.S.R H 8RS",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5879046320915222,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "IM WEARING A LOT AND YE HAD TEACHING FOR CANT STOP ME. L LR H 8RS",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.8629619479179382,
            "minimality": 0.75,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "IM WEARING A  LIR AND YUD A HOLD CANN CANT STOP ME. L.M..R H., SYNER L! I WILL NOT SOCCE B. HARLY",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.6380908489227295,
            "minimality": 1.5833333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "IM WEARING A  MY Y AND YARD M ONE ARE THE CANT STOP ME. LEEA AN M, PR H! <unk> XV. S",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9989629983901978,
            "minimality": 1.6666666666666667,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "IM WEARING A ROLLOWER AND YUM MY CANT STOP ME. L. R H.. WELCOM. A GROUPE. COLLATOR. (P.O., 2001.:",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.551188051700592,
            "minimality": 1.6666666666666667,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "IM WEARING A ROLLOWER AND YUM MY CANT STOP ME. L Y R H 0!. - <unk> ++ __.. ( ) : * ",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5528446435928345,
            "minimality": 1.9166666666666667,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "IM WEARING A SCHOOL AND YUMY LOOK CANT STOP ME. L.E.S.R H. H.R. P.D..W.L.E.S., W.O.K.M.A. WHY CAN MAKE SHE M. PERSON SUR CHOCHOY L.P.V.-SQDW!-P!PY!E PRISON WATCHING FOR THAN.F.B.G.C.H.T.I.N.Y.X.J. (Wow.Z.OR. C. R. T.U. K.",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9698724150657654,
            "minimality": 2.75,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 537.1930031776428,
            "error": false
          }
        ]
      }
    },
    {
      "id": "2",
      "result": {
        "input":
            "original sentence: @nabrathhhh Broken code can be devastating I think you're making light of what engineers do...Imagine some code at Twitter crashes and brings down the entire site for two hours and you aren't able to send your corny tweets anymore",
        "masked_index": [2, 12, 15, 20, 38],
        "orig_contrast_prob": 0.0009643156081438065,
        "orig_pred": "Rec",
        "contrast_pred": "Comp",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "original sentence:  0.0/nabrath.com Broken code can be devastating I think you're making  one of what  you do...Imagine some code at  the Bottom and brings down the entire site for two hours and you aren't able to send your corny code anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.8851163387298584,
            "minimality": 0.17391304347826086,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "original sentence:  I'mnabrath.com Broken code can be devastating I think you're making  any of what  you're doing to do...Imagine some code at  a time and brings down the entire site for two hours and you aren't able to send your corny stuff anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9924909472465515,
            "minimality": 0.1956521739130435,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "original sentence:  You getnabrath free. Broken code can be devastating I think you're making  some sort of what  you do...Imagine some code at  your door and brings down the entire site for two hours and you aren't able to send your corny mail anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9793903827667236,
            "minimality": 0.21739130434782608,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "original sentence:  I'm just thinkingnabrath! Broken code can be devastating I think you're making  mistakes of what  we do...Imagine some code at  all and brings down the entire site for two hours and you aren't able to send your corny phone anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9741942882537842,
            "minimality": 0.21739130434782608,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "original  code:  -nap code can be devastating I think you're  a fan of what  you do for some code at  the time and brings down the entire site for two hours and you aren't able to send your corny corn anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9981702566146851,
            "minimality": 0.2391304347826087,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "original sentence: \"I’m notnabrath? Broken code can be devastating I think you're making light of what the bad things do...Imagine some code at that. It crashes and brings down the entire site for two hours and you aren't able to send your corny tweets anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9852333664894104,
            "minimality": 0.2391304347826087,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "original sentence:  Thank you for thisnabrath.com.? Broken code can be devastating I think you're making  an impact of what  you do...Imagine some code at  home and brings down the entire site for two hours and you aren't able to send your corny code anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.6431179642677307,
            "minimality": 0.2608695652173913,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "original  code:  thisnab code can be devastating I think you're  just re-designing of what  you do with some code at  some point and brings down the entire site for two hours and you aren't able to send your corny site anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9480772018432617,
            "minimality": 0.2826086956521739,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "original  code:  anaive code can be devastating I think you're  the only one of what  we can do. We have some code at  the moment and brings down the entire site for two hours and you aren't able to send your corny code anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9438884854316711,
            "minimality": 0.30434782608695654,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "original  code code:  0.nab code can be devastating I think you're  unsure of what  you do. I tried to put some code at  this point and brings down the entire site for two hours and you aren't able to send your corny code anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.7836081981658936,
            "minimality": 0.32608695652173914,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "original  code:  Thenave code can be devastating I think you're  all aware of what  you do.! I don't use some code at  all and brings down the entire site for two hours and you aren't able to send your corny code anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.6894890666007996,
            "minimality": 0.32608695652173914,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "original sentence: \"I’m notnabrath.\" Broken code can be devastating I think you're making light of what your code will do...Imagine some code at it. If you want them to cause crashes and brings down the entire site for two hours and you aren't able to send your corny tweets anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5954257249832153,
            "minimality": 0.3695652173913043,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "original  code for: -)(andnap.com code can be devastating I think you're  out of what  you do, but it's still too bad to get some code at  the beginning and brings down the entire site for two hours and you aren't able to send your corny code anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9072622060775757,
            "minimality": 0.41304347826086957,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "original  message:: .? Thisnaive code can be devastating I think you're  out of what  you do. And I've used some code at  one time and brings down the entire site for two hours and you aren't able to send your corny code to a reputable organization not anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5984105467796326,
            "minimality": 0.45652173913043476,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "original sentence: \"I’m notnabrath, I’m not going to the site. \" Broken code can be devastating I think you're making light of what it would be like to do...Imagine some code at the moment your code crashes and brings down the entire site for two hours and you aren't able to send your corny tweets anymore",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5129817128181458,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 200.26055908203125,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "original sentence: @nabrath.com/repair @dmc. I'm a huge fan fanatic.jpg.html @nabrath.jm.x/dd.hoo.doc/pb/index.php.pdf! @ps.ca/default/nd/html _doc.in.id >1>. *#ninn.cc/cnn2_bcs_accom ;=x>>! I will try to start the process of Twitter. Thanks for the tweet. @cbb_ff.co.np?. This is my fault! \"I did",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9983164072036743,
            "minimality": 1.4130434782608696,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 200.26055908203125,
            "error": false
          }
        ]
      }
    },
    {
      "id": "3",
      "result": {
        "input": "We are the possible work together took for the programme.",
        "masked_index": [3, 5, 8],
        "orig_contrast_prob": 0.00015197315951809287,
        "orig_pred": "Comp",
        "contrast_pred": "Rec",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "We are the most efficient work manager for the scouts.",
            "new_pred": "Rec",
            "orig_label": "Comp",
            "new_contrast_prob_pred": 0.9746525287628174,
            "minimality": 0.45454545454545453,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 380.6607620716095,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "We are the  first team to work together  preparing for the project.",
            "new_pred": "Rec",
            "orig_label": "Comp",
            "new_contrast_prob_pred": 0.8802691102027893,
            "minimality": 0.45454545454545453,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 380.6607620716095,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "We are the  only people we have to work together  with for the project.",
            "new_pred": "Rec",
            "orig_label": "Comp",
            "new_contrast_prob_pred": 0.7587392926216125,
            "minimality": 0.6363636363636364,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 380.6607620716095,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "We are the  only group to work together , working together together for the project project.",
            "new_pred": "Rec",
            "orig_label": "Comp",
            "new_contrast_prob_pred": 0.8567985892295837,
            "minimality": 0.8181818181818182,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 380.6607620716095,
            "error": false
          }
        ]
      }
    },
    {
      "id": "4",
      "result": {
        "input": "In the programme of Madheram for the coming our country.",
        "masked_index": [0, 2, 5],
        "orig_contrast_prob": 0.00016046683595050126,
        "orig_pred": "Comp",
        "contrast_pred": "Rec",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "2. inputs to be included in the menu of Madheramin.",
            "new_pred": "Rec",
            "orig_label": "Comp",
            "new_contrast_prob_pred": 0.9851258993148804,
            "minimality": 0.9090909090909091,
            "num_edit_rounds": 1,
            "mask_frac": 0.48125000000000007,
            "duration": 290.88724184036255,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "2. inputs to be included in the menu of Madheram Madheram.",
            "new_pred": "Rec",
            "orig_label": "Comp",
            "new_contrast_prob_pred": 0.9322465658187866,
            "minimality": 1,
            "num_edit_rounds": 1,
            "mask_frac": 0.48125000000000007,
            "duration": 290.88724184036255,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "2. – 2. 1. output: 2. input: 3. input 1. input; 2. output. 3. output; 3. convert in. 2. 2. feed to input. 4. output output 2. 4. input output from the output on this. 1. rex. output input : 1. 1. add - to indicate the location of Madherama. 2. input input. 3. input output input 2. output output 2. 2. source output (dl) input = output. 5. output production output from the output in output, 2. feed output 1. input 1",
            "new_pred": "Rec",
            "orig_label": "Comp",
            "new_contrast_prob_pred": 0.635690450668335,
            "minimality": 10.818181818181818,
            "num_edit_rounds": 1,
            "mask_frac": 0.446875,
            "duration": 290.88724184036255,
            "error": false
          }
        ]
      }
    },
    {
      "id": "5",
      "result": {
        "input":
            "So you want to know why I only allow 1 nude.com post per month? Because ITS MY RIGHT ALONE",
        "masked_index": [10],
        "orig_contrast_prob": 0.33955955505371094,
        "orig_pred": "Rec",
        "contrast_pred": "Comp",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "So you want to know why I only allow 1 post per post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5683602690696716,
            "minimality": 0.1,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "So you want to know why I only allow 1 per month.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9789255857467651,
            "minimality": 0.1,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "So you want to know why I only allow 1 year and.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.744085967540741,
            "minimality": 0.1,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "So you want to know why I only allow 1 post an.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.7057206630706787,
            "minimality": 0.1,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "So you want to know why I only allow 1 post a.com.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.6899887919425964,
            "minimality": 0.1,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "So you want to know why I only allow 1 month per week post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.6726061701774597,
            "minimality": 0.15,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "So you want to know why I only allow 1 month for 1 post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5012204647064209,
            "minimality": 0.15,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "So you want to know why I only allow 1 post per month.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9815880060195923,
            "minimality": 0.15,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "So you want to know why I only allow 128 per monthde.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5238598585128784,
            "minimality": 0.15,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "So you want to know why I only allow 1200 post a month of post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.6526749730110168,
            "minimality": 0.25,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "So you want to know why I only allow 1 post post.com or the I.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.6778101921081543,
            "minimality": 0.25,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "So you want to know why I only  a month per month? Because ITS MY RIGHT NOW INONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9833934903144836,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "So you want to know why I only  ONE per month? Because ITS MY RIGHT IS MONEONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.5344325304031372,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "So you want to know why I only allow 1 post 1 single post per month post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.8232962489128113,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "So you want to know why I only allow 1 a single post per month on each.com post per month? Because ITS MY RIGHT ALONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.897119402885437,
            "minimality": 0.35,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "So you want to know why I only  spend the first time a month per month? Because ITS MY RIGHT.ONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9878151416778564,
            "minimality": 0.4,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 16,
            "edited_input":
                "So you want to know why I only  get one to pay a month per month? Because ITS MY RIGHT SALE! I only haveONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9965323209762573,
            "minimality": 0.6,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 51.72064709663391,
            "error": false
          },
          {
            "idx": 17,
            "edited_input":
                "So you want to know why I only  get 2 or 2 pounds per month? Because ITS MY RIGHT I'D LOVE YOU LOVE IT!!!!!!!!!!!!!!!! I HAVE NO REMENDING TO MY DE LONE OF MOST FORONE",
            "new_pred": "Comp",
            "orig_label": "Rec",
            "new_contrast_prob_pred": 0.9989545345306396,
            "minimality": 1.85,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 51.72064709663391,
            "error": false
          }
        ]
      }
    }
  ],
  "tweepfake": [
    {
      "id": "1",
      "result": {
        "input":
            "justin timberlake really one of the goats if you think about it.",
        "masked_index": [6],
        "orig_contrast_prob": 0.27614009380340576,
        "orig_pred": "Bot",
        "contrast_pred": "Human",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "justin timberlake really one of the ronalds if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8721840977668762,
            "minimality": 0.07692307692307693,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "justin timberlake really one of the trolls if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8281705975532532,
            "minimality": 0.07692307692307693,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "justin timberlake really one of the best movies if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9607877135276794,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "justin timberlake really one of the best posts if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8737229704856873,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "justin timberlake really one of the best quotes if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8140548467636108,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "justin timberlake really one of the most influential if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.6502363681793213,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "justin timberlake really one of the greatest filmmakers if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9350982904434204,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "justin timberlake really one of the best podcasts if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.899745762348175,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "justin timberlake really one of the best pubs if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8959565162658691,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "justin timberlake really one of the biggest dicks if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.846550703048706,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "justin timberlake really one of the best trolls if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8410391807556152,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "justin timberlake really one of the best dicks if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.7413018941879272,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "justin timberlake really one of the best shits if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.5099206566810608,
            "minimality": 0.15384615384615385,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "justin timber is really one of the best if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.7630650401115417,
            "minimality": 0.23076923076923078,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "justin timberlake really one of the most beautiful movies if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9822017550468445,
            "minimality": 0.23076923076923078,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "justin timberlake really one of the most valuable rallies if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.5565043091773987,
            "minimality": 0.23076923076923078,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 16,
            "edited_input":
                "justin timber is really one of the most beautiful if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.5202069878578186,
            "minimality": 0.3076923076923077,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 17,
            "edited_input":
                "justin timberlake really one of the best names on earth if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8174848556518555,
            "minimality": 0.3076923076923077,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 18,
            "edited_input":
                " There isin  a really one of the easiest scenarios if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8745612502098083,
            "minimality": 0.38461538461538464,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 19,
            "edited_input":
                " Beingin  Canada is really one of the best things if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.8700036406517029,
            "minimality": 0.38461538461538464,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 20,
            "edited_input":
                "justin timber is really one of the greatest economic sectors if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9765111804008484,
            "minimality": 0.38461538461538464,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 21,
            "edited_input":
                "justin timberlake really one of the biggest movies you can do if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9770235419273376,
            "minimality": 0.38461538461538464,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 22,
            "edited_input":
                " Gettingin  one of these is really one of the best if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9944759011268616,
            "minimality": 0.46153846153846156,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 23,
            "edited_input":
                " i'min  fact that's really one of the dumbest things about it if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.7473352551460266,
            "minimality": 0.6153846153846154,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 24,
            "edited_input":
                " Having to throwin  my own house is really one of the best things if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9351206421852112,
            "minimality": 0.6923076923076923,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 25,
            "edited_input":
                " Havingin  the bathroom is really one of the best things I can say if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.799246609210968,
            "minimality": 0.6923076923076923,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 32.582661151885986,
            "error": false
          },
          {
            "idx": 26,
            "edited_input":
                " Havingin  a car park is really one of the most annoying things you will have if you think about it.",
            "new_pred": "Human",
            "orig_label": "Bot",
            "new_contrast_prob_pred": 0.9359028935432434,
            "minimality": 0.8461538461538461,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 32.582661151885986,
            "error": false
          }
        ]
      }
    },
    {
      "id": "2",
      "result": {
        "input": "I Wanna See Some Rainbows Out There Boys.",
        "masked_index": [4, 7],
        "orig_contrast_prob": 0.035204481333494186,
        "orig_pred": "Human",
        "contrast_pred": "Bot",
        "prediction": [
          {
            "idx": 0,
            "edited_input": "I Wanna See Some  Myselfs Out There Is.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9988805651664734,
            "minimality": 0.2222222222222222,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 1,
            "edited_input": "I Wanna See Some  Is There Ther.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9996302127838135,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 2,
            "edited_input": "I Wanna See Some  Is There Again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9992333650588989,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 3,
            "edited_input": "I Wanna See Some  Man There Forgiveing.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7948764562606812,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 4,
            "edited_input": "I Wanna See Some  Tuck Out There I'm.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9985872507095337,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 5,
            "edited_input": "I Wanna See Some  I'm Out There Again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9982452392578125,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 6,
            "edited_input": "I Wanna See Some  Of Yourself Out There Out.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5025161504745483,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 7,
            "edited_input": "I Wanna See Some  Is There Id.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9997097849845886,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 8,
            "edited_input": "I Wanna See Some  of There 'No.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9992984533309937,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 9,
            "edited_input": "I Wanna See Some  Show There To Watch.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9911189675331116,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 10,
            "edited_input": "I Wanna See Some  New There #YogaDay.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.6238134503364563,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 11,
            "edited_input": "I Wanna See Some  Pieces Out There Is Then Do.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9996664524078369,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 12,
            "edited_input": "I Wanna See Some  Isn't There I'm Here.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9996706247329712,
            "minimality": 0.5555555555555556,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 13,
            "edited_input": "I Wanna See Some  Isn't There Just As They Have.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9996778964996338,
            "minimality": 0.6666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 14,
            "edited_input": "I Wanna See Some  Is There Thats So Big.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.999574601650238,
            "minimality": 0.6666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 15,
            "edited_input": "I Wanna See Some  Laughs There &amp; Indicators.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9860085844993591,
            "minimality": 0.6666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 16,
            "edited_input": "I Wanna See Some  More There &amp; more.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9592410326004028,
            "minimality": 0.6666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 17,
            "edited_input":
                "I Wanna See Some  Of Out There Is Nothing I'm Ever.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.99977046251297,
            "minimality": 0.6666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 18,
            "edited_input":
                "I Wanna See Some  Time Out There Is A Big A Close.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9997162222862244,
            "minimality": 0.6666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 19,
            "edited_input":
                "I Wanna See Some  People I Saw Out There And And There.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.928703784942627,
            "minimality": 0.6666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.20625000000000002,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 20,
            "edited_input":
                "I Wanna See Some  One There Is A Million For People.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9983312487602234,
            "minimality": 0.7777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          },
          {
            "idx": 21,
            "edited_input":
                "I Wanna See Some  Meilens! There Was nothing wrong with these.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.611572802066803,
            "minimality": 0.7777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 27.662789821624756,
            "error": false
          }
        ]
      }
    },
    {
      "id": "3",
      "result": {
        "input":
            "Spent a great afternoon in Rohtak. Haryana has witnessed transformative changes in the last five years. Corruption and nepotism have disappeared",
        "masked_index": [3, 5, 8],
        "orig_contrast_prob": 0.0001948582794284448,
        "orig_pred": "Human",
        "contrast_pred": "Bot",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "Spent a great  work in  Lamantak. Haryana has risen changes in the last five years. Corruption and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7059759497642517,
            "minimality": 0.17391304347826086,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "Spent a great  economy in  Haryana @tak. Haryana has made major changes in the last five years. Corruption and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9904762506484985,
            "minimality": 0.21739130434782608,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "Spent a great afternoon in  Karnataka Haryana @KayanMoryanaAtak. Haryana has made several changes in the last five years. Corruption and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8661374449729919,
            "minimality": 0.21739130434782608,
            "num_edit_rounds": 1,
            "mask_frac": 0.10312500000000001,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "Spent a great  development in  Mahagary's Pratak. Haryana has made major changes in the last five years. Corruption and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9912059903144836,
            "minimality": 0.2608695652173913,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "Spent a great  politician in  Kantak.  Pratak has  been working in the last five years. Rajasis and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9996539354324341,
            "minimality": 0.30434782608695654,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "Spent a great  success in  @Khowitak.  It has  been terrible in the last five years. Moreover and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9996275901794434,
            "minimality": 0.30434782608695654,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "Spent a great  politician in  @Datak.  It has  been in the last five years. Democratism and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9994938373565674,
            "minimality": 0.30434782608695654,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "Spent a great  reputation in  Ketak.  It has  been in the last five years. Government and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9992741942405701,
            "minimality": 0.30434782608695654,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "Spent a great  reputation in  thetak.  Hate has  remained strong in the last five years. Politicism and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.997674286365509,
            "minimality": 0.30434782608695654,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "Spent a great  business in  thetak.  It has  been in the last five years. The corruption and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.990097165107727,
            "minimality": 0.34782608695652173,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "Spent a great  man in  thetak.  This has  happened in the last five years. The sexism and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9812633991241455,
            "minimality": 0.34782608695652173,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "Spent a great  tak in  thetak.  He has  died in the last five years. His corruption and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9218169450759888,
            "minimality": 0.34782608695652173,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "Spent a great  career in  #tak.  Nadak has  been there in the last five years. Tawak and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9058353900909424,
            "minimality": 0.34782608695652173,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "Spent a great  man in  thetak.  He has  suffered multiple economic problems in the last five years. His socialism and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9984329342842102,
            "minimality": 0.391304347826087,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "Spent a great  tak in  thetak.  NaNoWrt. It has  disappeared in the last five years. The wealth and nepotism have disappeared",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8214948177337646,
            "minimality": 0.391304347826087,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 61.53910994529724,
            "error": false
          }
        ]
      }
    },
    {
      "id": "4",
      "result": {
        "input": "getting a 4k monitor so i can make posts.",
        "masked_index": [0],
        "orig_contrast_prob": 0.008943802677094936,
        "orig_pred": "Human",
        "contrast_pred": "Bot",
        "prediction": [
          {
            "idx": 0,
            "edited_input": " i'm a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9890599250793457,
            "minimality": 0.2,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 1,
            "edited_input": " i need a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5789427161216736,
            "minimality": 0.2,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 2,
            "edited_input": " i'm a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9890599250793457,
            "minimality": 0.2,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 3,
            "edited_input": " i need a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5789426565170288,
            "minimality": 0.2,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 4,
            "edited_input": " I'm a 4k blog so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9983376264572144,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 5,
            "edited_input": " i have a 4k server so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.956234335899353,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 6,
            "edited_input": " I had a 4k account so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9509597420692444,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 7,
            "edited_input": " i had a 4k project so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9477647542953491,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 8,
            "edited_input": " i'm a 4k old so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9385830163955688,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 9,
            "edited_input": " i have a 4k project so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9092386960983276,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 10,
            "edited_input": " i have a 4k blog so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8790541291236877,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 11,
            "edited_input": " @StateNews I'm a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.957457959651947,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 12,
            "edited_input": " i just need a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8376708626747131,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 13,
            "edited_input": " i've created a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.6935861110687256,
            "minimality": 0.3,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 14,
            "edited_input": " i've created a 4k post so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8273099660873413,
            "minimality": 0.4,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 15,
            "edited_input": " i have a 4k of code so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.6427962183952332,
            "minimality": 0.4,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 16,
            "edited_input": " \"My wall is a 4k monitor so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9357367753982544,
            "minimality": 0.4,
            "num_edit_rounds": 1,
            "mask_frac": 0.034375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 17,
            "edited_input": "i need a fewk sticks so i can make you.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9760530591011047,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 18,
            "edited_input": "i need a fewk coins so i can make it.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9231352806091309,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 19,
            "edited_input": "i need a fewk dick so i can make that.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5201805233955383,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 20,
            "edited_input": " we got a  few ofk  posts so i can make it.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9838485717773438,
            "minimality": 0.6,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 21,
            "edited_input": " i have a  dnk  kn so i can make me happy.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9307674765586853,
            "minimality": 0.6,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 22,
            "edited_input": "i need a fewk of me so i can make them.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8968969583511353,
            "minimality": 0.6,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 23,
            "edited_input": " it's a  dmk  k so i can make a profit.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7866607308387756,
            "minimality": 0.6,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 24,
            "edited_input": " I have a  few 100k  lil so i can make you go.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9935317635536194,
            "minimality": 0.7,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 25,
            "edited_input":
                " it's a  40k  video game so i can make a difference.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9471750855445862,
            "minimality": 0.7,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 26,
            "edited_input": " have a  dm:k , so i can make a mistake.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9126153588294983,
            "minimality": 0.7,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 27,
            "edited_input": "i need a fewk of trash so i can make the noise.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9110043048858643,
            "minimality": 0.7,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 28,
            "edited_input": " i need a  few milk  of it so i can make them.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5084865689277649,
            "minimality": 0.7,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 29,
            "edited_input":
                " I've made posts at a 4k of times so i can make posts.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9976322650909424,
            "minimality": 0.7,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 30,
            "edited_input":
                "i need a fewk of water so i can make my own friends.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9581446051597595,
            "minimality": 0.8,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 31,
            "edited_input":
                " you need a  a 20k  app so i can make your own version.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7861829400062561,
            "minimality": 0.8,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 32,
            "edited_input": "i need a fewk on my desk so i can make a fewk.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5383663773536682,
            "minimality": 0.8,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 33,
            "edited_input":
                " i just need a  onek  to add so i can make your own mistakes.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.996038556098938,
            "minimality": 0.9,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 34,
            "edited_input":
                " i want to give a  kk  and so i can make some of you.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9940415024757385,
            "minimality": 0.9,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 35,
            "edited_input":
                "i need a fewk bags so i can make me look like an old version.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7582626342773438,
            "minimality": 1,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          },
          {
            "idx": 36,
            "edited_input":
                " u just a  fewk  in front of the bus so i can make a little effort.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5686489939689636,
            "minimality": 1.1,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 33.644487142562866,
            "error": false
          }
        ]
      }
    },
    {
      "id": "5",
      "result": {
        "input":
            "Once a product has FDA approval, the legislation would allow its sale in San Francisco again.",
        "masked_index": [4, 14],
        "orig_contrast_prob": 0.19576703011989594,
        "orig_pred": "Human",
        "contrast_pred": "Bot",
        "prediction": [
          {
            "idx": 0,
            "edited_input":
                "Once a product has  FDA approval and approval, the legislation would allow its sale in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9707551598548889,
            "minimality": 0.1111111111111111,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 1,
            "edited_input":
                "Once a product has  received FDA approval and approval, the legislation would allow its sale in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.945980429649353,
            "minimality": 0.16666666666666666,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 2,
            "edited_input":
                "Once a  player has  been fired, the  president would allow its  sale in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9931898713111877,
            "minimality": 0.2222222222222222,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 3,
            "edited_input":
                "Once a product has  approval for approval, the  Atari Administration would allow its sale in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8536937236785889,
            "minimality": 0.2222222222222222,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 4,
            "edited_input":
                "Once a product has  received approval for approval, the  FDA would allow its sale in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.6353977918624878,
            "minimality": 0.2222222222222222,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 5,
            "edited_input":
                "Once a product has  approved approval and without approval, the legislation would allow its sale in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.5754484534263611,
            "minimality": 0.2222222222222222,
            "num_edit_rounds": 1,
            "mask_frac": 0.06875,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 6,
            "edited_input":
                "Once a  roBot has  been released, the  public would allow its  location in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9960083961486816,
            "minimality": 0.2777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 7,
            "edited_input":
                "Once a  fan has  been done, the  media would allow its  presence in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9942523837089539,
            "minimality": 0.2777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 8,
            "edited_input":
                "Once a  Human has  lost, the  government would allow its  shit in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9929109215736389,
            "minimality": 0.2777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 9,
            "edited_input":
                "Once a  guy has  been arrested, the  police would allow its  people in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9438692927360535,
            "minimality": 0.2777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 10,
            "edited_input":
                "Once a  computer has  been used, the  government would allow its  users in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9173362851142883,
            "minimality": 0.2777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 11,
            "edited_input":
                "Once a product has  written approval and approval, the  company would allow its sale in San Diego again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8920456171035767,
            "minimality": 0.2777777777777778,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 12,
            "edited_input":
                "Once a  new person has  died, the  state would allow its  people in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9921149611473083,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 13,
            "edited_input":
                "Once a  computer has  been approved, the  FBI would allow its  release in San Diego again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.968853771686554,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 14,
            "edited_input":
                "Once a  person has  an issue, the  FBI would allow its  a stop in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9673632979393005,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 15,
            "edited_input":
                "Once a  person has  some help, the  state would allow its  release in San Antonio again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9477548003196716,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 16,
            "edited_input":
                "Once a  guy has  died, the  FBI would allow its  shit in San Diego again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9018470644950867,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 17,
            "edited_input":
                "Once a product has  received approval and has received approval, the  FDA would allow its sale in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.8960936069488525,
            "minimality": 0.3333333333333333,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 18,
            "edited_input":
                "Once a  Bot has  been done, the  Fed would allow its  people to sit in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7832467555999756,
            "minimality": 0.3888888888888889,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 19,
            "edited_input":
                "Once a  person has  been working hard enough, the  media would allow its  back in San Diego again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9909413456916809,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 20,
            "edited_input":
                "Once a  person has  no idea what to do, the  FBI would allow its  troll in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9284301996231079,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 21,
            "edited_input":
                "Once a product has  approved and is approved for public approval, the  FDA would allow its sale in San Diego again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.7327508330345154,
            "minimality": 0.4444444444444444,
            "num_edit_rounds": 1,
            "mask_frac": 0.1375,
            "duration": 30.166480779647827,
            "error": false
          },
          {
            "idx": 22,
            "edited_input":
                "Once a  person has  been in San Francisco, the  State would allow its  people to live in San Francisco again.",
            "new_pred": "Bot",
            "orig_label": "Human",
            "new_contrast_prob_pred": 0.9739236831665039,
            "minimality": 0.5,
            "num_edit_rounds": 1,
            "mask_frac": 0.275,
            "duration": 30.166480779647827,
            "error": false
          }
        ]
      }
    }
  ]
};
