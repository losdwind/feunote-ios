//
//  PPCard.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/21.
//

import Foundation
import SwiftUI

struct PPCard: Identifiable, Hashable{
    var id:String = UUID().uuidString
    var title:String = ""
    var description:String = ""
    var detail:String = ""
    var imageURL:String = ""
    var cardColor:Color = Color(.white)
    var category:String = ""
}

let PPCards:[PPCard] = [
    PPCard(title: "Savoring", description: "Savoring is the act of stepping outside of an experience to review and appreciate it. Savoring intensifies and lengthens the positive emotions that come with doing something you love.", detail: "Savoring is the act of stepping outside of an experience to review and appreciate it. Savoring intensifies and lengthens the positive emotions that come with doing something you love. Everyday, practice the art of savoring by picking one experience to truly savor each day. It could be a nice shower, a delicious meal, a great walk outside, or any experience that you really enjoy. When you take part in this savored experience, be sure to practice some common techniques that enhance savoring. These techniques include: sharing the experience with another person, thinking about how lucky you are to enjoy such an amazing moment, keeping a souvenir or photo of that activity, and making sure you stay in the present moment the entire time.", imageURL: "", cardColor: Color.ewDecorative1, category: "Savoring"),
    
    PPCard(title: "Gratitude", description: "Gratitude is a positive emotional state in which one recognizes and appreciates what one has received in life. Research shows that taking time to experience gratitude can make you happier and even healthier.", detail: "Gratitude is a positive emotional state in which one recognizes and appreciates what one has received in life. Research shows that taking time to experience gratitude can make you happier and even healthier. For the next seven days, take 5-10 minutes each night to write down five things for which you are grateful. They can be little things or big things. But you really have to focus on them and actually write them down. You can just write a word or short phrase, but as you write these things down, take a moment to be mindful of the things you’re writing about (e.g., imagine the person or thing you’re writing about, etc.). This exercise should take at least five minutes. Do this each night for the whole week.", imageURL: "", cardColor: Color.ewDecorative2, category: "Gratitude"),
    
    
    PPCard(title: "Kindness", description: "Research shows that happy people are motivated to do kind things for others.", detail: "Research shows that happy people are motivated to do kind things for others. Over the next seven days, try to perform seven acts of kindness beyond what you normally do. You can do one extra act of kindness per day, or you can do a few acts of kindness in a single day. These do not have to be over-the-top or time-intensive acts, but they should be something that really helps or impacts another person. For example, help your colleague with something, give a few dollars or some time to a cause you believe in, say something kind to a stranger, write a thank you note, give blood, and so on. At the end of each day, list your random act of kindness. Just make sure you've finished seven total new acts of kindness by the end of the week.", imageURL: "", cardColor: Color.ewDecorative3, category: "Kindness"),
    
    
    
    PPCard(title: "Social Connection", description: "Research shows that happy people spend more time with others and have a richer set of social connections than unhappy people. Studies even show that the simple act of talking to a stranger on the street can boost our mood more than we expect. ", detail: "Research shows that happy people spend more time with others and have a richer set of social connections than unhappy people. Studies even show that the simple act of talking to a stranger on the street can boost our mood more than we expect. This week, you will try to focus on making one new social connection per day. It can be a small 5-minute act like sparking a conversation with someone on public transportation, asking a coworker about his/her day, or even chatting to the barista at a coffee shop. At least once this week, take a whole hour to connect with someone you care about. The key is that you must take the time needed to genuinely connect with another person. At the end of the day, list the social connection you made and notice how you feel when you jot it down.", imageURL: "", cardColor: Color.ewDecorative4, category: "connection"),
    
    PPCard(title: "Gratitude letter/visit", description: "Research suggests will have a big impact on your happiness and that of another person.", detail: "research suggests will have a big impact on your happiness and that of another person. This week, write a letter of gratitude to someone you care about. For this assignment, think of one living person who has made a big difference in your life, but whom you never properly thanked. Then find a quiet spot when you have a half-hour free and write a heartfelt letter to that person explaining how he or she has touched your life and why he or she is meaningful to you. Your letter can be as long as you want, but try to make it at least 300 words or so. Then you must deliver that letter to the person in question. Just say you want to talk to that person without explaining why. You could read the letter to your chosen person over the phone or Skype, but for an extra huge happiness boost, we recommend scheduling a time to visit this person in person to share your letter. However you meet up, you should read the letter aloud. We also recommend that you both have some tissues handy for this one. A gratitude letter is one of the most powerful tool for increasing happiness because it can forge social bonds and really change someone’s life.", imageURL: "", cardColor: Color.ewDecorative5, category: "Gratitude")
    

]
