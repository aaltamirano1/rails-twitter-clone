module TweetsHelper
	def get_tagged(tweet)
		message_arr = Array.new
		message_arr = tweet.message.split
    message_arr.each_with_index do |word, i|
      if word[0] == '#'
        if Tag.pluck(:phrase).include?(word.downcase)
          tag = Tag.find_by(phrase: word.downcase)
        else
          tag = Tag.create(phrase: word.downcase)
        end
        tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        message_arr[i] = "<a href='/tag_tweets?id=#{tag.id}' class='hashtag'>#{word}</a>"
      end
    end
    tweet.message = message_arr.join(" ")
    return tweet
	end
  def hot_tags
    # tags = Tag.order("created_at DESC").limit(10)

    tweets = TweetTag.all
    if tweets.length>0
      tag_arr = []
      tag_ids = []

      tags = TweetTag.all.group_by {|h| h['tag_id']}.to_a.sort_by{|x| x[1].length}
      count = 1

      3.times do
        tag_ids.push(tags[tags.length-count][0])
        count +=1
      end

      tag_ids.each do |phrase|
        tag_phrase = Tag.find(phrase)
        tag_arr.push(tag_phrase)

      end

      return tag_arr
    end
  end

end
