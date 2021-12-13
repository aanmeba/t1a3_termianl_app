
def heading(text)
    system('clear')
    puts Arti.asciify(text)
    puts " Let's #{text}! ".colorize(:black).on_light_blue
end
