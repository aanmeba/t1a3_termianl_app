require 'tty-prompt'
require 'colorize'

prompt = TTY::Prompt.new

String.colors
String.color_samples

title = "Split The Bills"

puts "Let's #{title}!"
puts "Enter your name"
name_array = []
input = gets.chomp.downcase
name_array << input

while input
    puts "Enter names who you are gonna split the bills one by one.\s\nIf you finish it, please type 'done'"
    input = gets.chomp.downcase
    if input == "done"    
        if name_array.length == 1
            puts "You should enter one more person."
        else
            break
        end
    else
        name_array << input
    end
end

bill_validation = true
while bill_validation
    puts "How much of your total bill?"
    bill = gets.chomp.to_f

    yes_no = prompt.yes?("Your total bill is #{bill}, is it correct?") do |q|
        q.required true
        q.modify   :down
    end
    
    case yes_no
    when true
        puts "Alright, let's split the bill."
        bill_validation = false        
    when false
        puts "Oh, then please enter the correct amount."
    end
   
end

puts "Choose how you are going to split the bill. R) Random E) Equal"
