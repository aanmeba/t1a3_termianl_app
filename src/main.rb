
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
    return name_array
end

bill_validation = true
while bill_validation
    puts "How much of your total bill?"
    bill = gets.chomp.to_f

    puts "Your total bill is #{bill}, is it correct?"
    yes_no = gets.chomp.downcase

    case yes_no
    when "yes", "y"
        puts "Alright, let's split the bill."
        bill_validation = false
    when "no", "n"
        puts "Oh, then please enter the correct amount."
    end
    return bill
end

puts "bill validation done. let's move on the next step!"
