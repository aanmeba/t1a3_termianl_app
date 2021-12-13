# T1A3 - Terminal Application

## Source Control Repository
[repo](https://github.com/aanmeba/t1a3_termianl_app)

## Software Development Plan

개요
특정 금액을 여러 사람이 부담해야하는 경험은 누구나 있다. 그럴 때 이를 균등하게 나누거나 게임 처럼 랜덤으로 서로 다른 금액을 낼 수도 있고, 자신이 낼 수 있는 만큼을 미리 정할 수도 있다. 이 앱은 그런 기능을 가지고 있어서 친구들이나 지인들과 식사를 하고, 선물을 사거나 다양한 상황에서 사용할 수 있다. 금액을 부담할 사람들의 이름을 먼저 입력하고, 총 액수를 입력한다. 균등하게 나눌지, 랜덤하게 나눌지, 수동으로 입력할지를 선택하면 결과가 화면에 표시된다.

scope
- top-level purpose, 어떤 것을 달성했을 때 프로젝트가 끝났다고 말할 수 있는지. 
빌을 나눠서 낼 때는 크게 세 가지 상황을 고려해 볼 수 있다. 균등하게 나누거나 랜덤하게 나누거나 내고싶은 금액을 직접 정하는 방식이 있을 수 있다. 유효한 입력값을 받아서 유저가 원하는 방식으로 계산하고 이를 표시하는 것이 이 앱의 MVP 스코프이다. edge case를 고려하여 입력값의 유효성 검사를 해서 정확한 결과를 표시해야 한다.

---------------------------------------------

This terminal application is for splitting a bill. Many of us have this experience of sharing a specific amount, whether it is having dinner with friends or any group expense. Most applications in the market provide sharing the amount equally, but what if there are other options? 

Let's say that the total bill is $99 and you are going to share it with two other friends. Is it the only option to pay $33 for each? If you can divide it into $90, $9, and $0, it is going to be thrilling. Or sometimes you just don't want to have the change so want to pay $50 then your friends are just going to share the rest. This application provides users with more options with these three scenarios, one of which is to split the bill evenly, the next one is to share different amounts each, and the last one is for users to take up their share as much as they want. 

Based on these three situations, this program takes valid inputs, calculates them depending on a user's choice, and displays the results user-friendly. In addition, it has to handle the edge cases to return the exact value. When it comes to the valid inputs, there are two types of data, one of which is names and another is amount. This will only take alphabets for names and positive numbers for amount. As for the manual option, the amount input can be positive numbers as well as zero (0).

Users simply enter more than two names and the total amount they want to share. Then it displays options to divide the amount equally, randomly, or manually and the user can choose one of the options using arrow keys.


## Features

* Split Equally

This divides the input amount evenly. In some cases that the amount can't be equally split up by the number of people, it randomly chooses one person to take the rest. For example, there are 3 people and the total amount is $100. In general, a calculator returns 33.333333333.... but it is not ideal in our real life. So this is going to be $33.33, $33.33, and $33.34.

This calculation is done in 2 decimal points so the sum of the 100/3 result is 99.99. This feature verifies the input amount and the sum of the result. If this is not the same, it picks a random number and adds it to the corresponding person. 

* Split Randomly

This divides the input amount randomly. First, it generates an array of random numbers and the length of the array is the same as the number of people. If it creates all the elements in the array that are 0, it will trigger ZeroDivisionError in the next step so it regenerates another array until the array is valid. 

Then, it divides the total amount by the sum of elements in the random array and the result value is the threshold price. And then, it multiplies each element in the random number and the threshold price. Finally, it returns an array of randomly divided amounts.

* Split Manually

This accepts the user input manually to share the amount. Since it takes user inputs so handling edge cases are important to remove any errors. It validates if the inputs are positive numbers including zero (0), otherwise, when input values are alphabets, symbols, and negative numbers, it raises warning messages and accepts another input from the user.

When the last person left after entering the amount for each, it automatically calculates the rest and allocates it to the last person, and then displays the result on the screen. 


## User Interaction & Experience

Typing '-help' or '-info' in the command line when executing this application displays further information to use it. Users can enter names and amounts following the instruction then select an option using the arrow keys. 

------------------------------
Develop an outline of the user interaction and experience for the application.
Your outline must include:
- how the user will find out how to interact with / use each feature
- how the user will interact with / use each feature
- how errors will be handled by the application and displayed to the user

지시에 따라 입력하거나 목록에서 선택
입력값으로 계산하는 앱이라 에러가 그다지 ..

argv - 앱을 실행할 때 command line으로 -help와 -info를 사용해 정보를 얻을 수 있음.
지시에 따라 이름과 금액을 입력하면 선택할 수 있는 메뉴가 나타남.
방향키로 원하는 메뉴를 선택할 수 있음. 

input validation을 통해 invalid 값을 입력하면 오류메시지가 표시되고 다시 입력할 수 있음.
--------------------------


## Control flow

Develop a diagram which describes the control flow of your application. Your diagram must:
- show the workflow/logic and/or integration of the features in your application for each feature.
- utilise a recognised format or set of conventions for a control flow diagram, such as UML.

## Implementation Plan -> Trello

Develop an implementation plan which:
- outlines how each feature will be implemented and a checklist of tasks for each feature
- prioritise the implementation of different features, or checklist items within a feature
- provide a deadline, duration or other time indicator for each feature or checklist/checklist-item

Utilise a suitable project management platform to track this implementation plan

> Your checklists for each feature should have at least 5 items.

https://trello.com/b/l7Rq2BOL/t1a3-terminal-app


## How to install and use

Design help documentation which includes a set of instructions which accurately describe how to use and install the application.

You must include:
- steps to install the application
- any dependencies required by the application to operate
- any system/hardware requirements

### Requirements (dependencies, system/hardware)





