# Godot Game project

## About and Tech Stack

The Game will be made with Godot(The best game-engine that exist) with [Rust Bindings]((https://godot-rust.github.io/)).
the relationship betwenn rust and gaming is just beginning, and i'll make part of that.

### Game Concept

A strategy game that runs on phases:
 - Positioning
 - Attacking
 - Repositioning

The game is set on the world map with continents and countries being the territories where the players will battle to conquer and put their tropes.

#### Positioning

In the positioning phase you will gain some troops that you can put in your territories.

T = territories that you have


troops count : 3 + (T / 2)
For example  

6 territories, you gain 6 troops.

10 territories, you gain 8 troops.

The first time that you conquer the territory you will gain their card, gaining all the continent's territories cards will give you some permanent bonus on positioning phase based on the size of the continent.

#### Attacking

In the attacking phase you can select some of your territory and attack any other territories that is not yours that is on your's selected territory boundaries

the attack match is defined by the following parameters

- how many troops you select to attack
- how many troops the enemy has
- your chances

first you have to choose the quantity of troops to attack based on how much troops you have on the selected territory (the attacking territory).
If you win the attack, the quantity of troops that you selected will be subtracted on the quantity of troops that the selected enemy territory has(the defending territory), in the other way, if you loose, the selected quantity will be subtracted of your territory.

You can attack until you have 1 troop or the enemy has more than 1 troop... if he has 0 troops you gain the territory winning 1 troop to replace the enemy troop allowing you to move some troops to the new conquered territory on the repositioning phase

the success of the attack is defined by the two players generating a random number between 0 and the Power count number, the default being 5, the highest number wins.

#### repositioning

On the repositioning phase you can select troops to move to already own territories from already own territories that has more than 1 troop that is on bounds. 

### Technical

  Read the **[About](./game/ABOUT.md)** file for more technical information about the game.
