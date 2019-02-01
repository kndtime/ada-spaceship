# Space Invasion for MakeWithAda 2018

This project is a game realized for a school project at EPITA.
This repository is part of a competition for Ada programming. This project was done using Ada 2012 standards for the STM32F429-Discovery.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
Gnat Toolchain
GPS : Gnat Programming Software
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
git clone https://github.com/kndtime/ada-spaceship
Import the spaceship.gpr file from GPS
Compile the code
Flash the executable on the STM32F429-Discovery
```
Here is a screen of a board running the game.

![Alt text](https://raw.githubusercontent.com/kndtime/ada-spaceship/master/board.jpg?raw=true "Title")


## Running the tests

Some we did not implement tests but we sure used Ada contract to assure that the code will not be buggy.


```ada
procedure set_dmg(s : in out Spaceship; dmg: Integer)
with
     Pre => s.State /= DEAD and dmg /= 0,
    Post => (if s.Life <= 0 then
                s.State = DEAD);
```

## Built With

* [GNAT](https://www.adacore.com/community) - The Ada Compiler used
* [Ada_Drivers_Library](https://github.com/AdaCore/Ada_Drivers_Library) - Drivers for the STM32F429
* [Stlink](https://github.com/texane/stlink) - Used to flash the code on the card

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Axel Banal** - *Initial work* - [Kndtime](https://github.com/Kndtime)
* **Antoine Lebeury** - *Initial work* - [Kndtime](https://github.com/antoine-lebeury)


See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
