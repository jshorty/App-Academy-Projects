module TracksHelper

 def ugly_lyrics(lyrics)
   lyrics = h("♫") + lyrics.strip.gsub("\n", "\n#{h("♫")}")
   "<pre>#{lyrics}</pre>".html_safe
 end
end
