require 'tty-prompt'
require 'colorize'
require_relative './methods'

prompt = TTY::Prompt.new

title = "Split The Bills".colorize(:light_red)
# ask_name = "Enter your name".colorize(:light_cyon)

puts "Let's #{title}!"
puts "Enter your name".colorize(:light_blue)
name_array = []
input = gets.chomp.downcase
name_array << input

while input
    puts "Enter names who you are gonna split the bills one by one.\s\nIf you finish it, please type 'done'".colorize(:light_blue)
    input = gets.chomp.downcase
    if input == "done"    
        if name_array.length == 1
            puts "You should enter one more person.".colorize(:light_blue)
        else
            break
        end
    else
        name_array << input
    end
end

bill_validation = true
while bill_validation
    puts "How much of your total bill?".colorize(:light_blue)
    bill = gets.chomp.to_f

    yes_no = prompt.yes?("Your total bill is #{bill}, is it correct?".colorize(:light_blue)) do |q|
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

calculator_instance = Calculator.new(name_array, bill)

choices = [
        {name: 'I\'m feeling lucky!', value: 1},
        {name: 'equally', value: 2},
        {name: 'Exit', value: 3}
      ]

user_input = prompt.select("Choose how you are going to split the bill.", choices)

case user_input
when 1
    y_n_input = prompt.yes?("Would you like to set a maximum amount for each person?") do |q|
        q.required true
        q.modify   :down
    end

    # this going to be into hell....
    # call the methods...
    
when 2
    puts "Alright, let's split the bill equally..."
    return_value = calculator_instance.split_equally(name_array.length, bill)
    calculator_instance.display(name_array, return_value)
    exit

when 3
    puts "Bye for now!"
end
