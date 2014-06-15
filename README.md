pd2-setgame-peter-alex-benny
============================

Repository for AP CS Final Project - Set Game (Peter Duchovni, Benny Deng, Alex Ioustous)

Preliminaries
=============

Requirements
------------

* `processing` (Processing)
* `asy` (Asymptote)


Compiling
---------

* Ensure `asy` command is in environment path
* Run `make`
* Open `gui/gui.pde` in Processing
* Run sketch


Playing the Game
================


Game Mechanics
--------------

The game Set consists of a deck of 81 unique cards with distinguishing properties:

* Color (Red, Purple, or Green)
* Number (One, Two, or Three)
* Shape (Oval, Diamond, or Wave)
* Shading (Empty, Shaded, or Filled)

The goal of the game is to construct *sets*, which consist of three cards which are uniform or unique across all properties; in other words,

* Every card has a unique color, or all have the same color
* Every card has a unique number of shapes, or all have the same number of shapes
* Every card has a unique shape, or all have the same shape
* Every card has a unique shading, or all have the same shading

A certain number of cards (usually 12) are dealt face-up, and the player removes three cards that constitute a set. If the cards are indeed a set, three more cards are drawn, otherwise the cards are placed back. If there are no possible sets among the cards dealt out, an additional three cards are dealt as necessary. Once the deck is empty and there are no sets among the face-up cards, the game is over.



Gameplay
--------

In the set game GUI application, the user can click on cards to select or deselect them. The user may only click on three cards at a time; after a fourth card is clicked, all cards are deselected, as sets consist of exactly three cards. Once three cards are selected, the user may press 'return' or 'enter' in order to indicate that they believe the three selected careds form a set, or the user may press 'backspace' or 'delete' at any time to automatically deselect all selected cards. The number of sets present is displayed in the upper left-hand corner of the screen, and the number of sets the user has found is displayed in the bottom right. To the right of the available set counter is a display indicating the largest number of sets that may be formed simultaneously, i.e. without any cards in common. It is guaranteed that there will always be at least one set present at any time, with the exception of when the deck runs out of cards. If the user is unable to find a set, they may obtain a hint by pressing 'h' or '?' with any number of cards currently clicked. The following hints are provided:

* If zero cards are selected, the most ideal set will be automatically selected.
* If one card is selected, a set involving that card will be selected, if one exists
* If two cards are selected, the set involving those two cards will be selected, if present

To quit at any time, press 'q'; to start a new game at any time, press 'n'.
