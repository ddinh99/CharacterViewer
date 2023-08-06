// By: Dai Dinh
// 8/3/2023

class SimpsonCharacter
{
  String firstURL;
  String result;
  String text;
  String iconURL;
  String height;
  String width;
  String charName;

  SimpsonCharacter({
    required this.firstURL,required this.result, required this.text,
    required this.iconURL,required this.height,required this.width,required this.charName}
);
}

final List<SimpsonCharacter> characterList = [];

void parseData(Map<String, dynamic> data)
{
  characterList.clear();
  List<dynamic> relatedTopicsList = data['RelatedTopics'];
    for (int i = 0; i <relatedTopicsList.length; i++)
      {
        String firstURL = relatedTopicsList[i]['FirstURL'];
        String result = relatedTopicsList[i]['Result'];
        String text =  relatedTopicsList[i]['Text'];
        Map<String, dynamic> iconData = relatedTopicsList[i]['Icon'];
        String height =iconData['Height'];
        String iconURL = iconData['URL'];
        String width = iconData['Width'];
        String charName = extractTextBeforeDash(text);
        SimpsonCharacter aChar = SimpsonCharacter(firstURL: firstURL, result: result, text: text, iconURL: iconURL, height: height, width: width,charName: charName);
        characterList.add(aChar);
      }

}

String extractTextBeforeDash(String inputString) {
  int dashIndex = inputString.indexOf('-');
  if (dashIndex != -1) {
    return inputString.substring(0, dashIndex).trim();
  } else {
    return inputString;
  }
}