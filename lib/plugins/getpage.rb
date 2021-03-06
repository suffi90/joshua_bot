class Getpage < Plugin
  def command
    /^\/getpage (.+?)$/
  end

  def show_usage
    bot.api.sendMessage(chat_id: message.chat.id, text: "if you want get image of a webpage type:\n/getpage *website URL*")
  end

  def do_stuff(match_results)
    website_url = match_results[1]
    link = "https://http2pic.haschek.at/api.php?onfail=https://i.imgur.com/ysPo1A4.jpg&js=no&url=#{website_url}"
    temp_file = "#{Time.new.to_i}.jpg"

    puts "[!] fething the image from http2pic"
    system("wget \"#{link}\" -O #{temp_file}")

    bot.api.sendPhoto(chat_id: message.chat.id, photo: File.new(temp_file))
    bot.api.sendMessage(chat_id: message.chat.id, text: "🔎check out http2pic at https://http2pic.haschek.at")

    File.delete(temp_file)
  end
end
