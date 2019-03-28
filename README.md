# MarvelApp

This application is intended to list Super Heroes being presented on [Marvel API](https://developer.marvel.com/)

## Branch feature/view-code
The branch `feature / view-code` is implemented using the `SnapKit` framework for assembly of the screens, without the use of `Storyboard` or Xib, in addition to the implementation with Reusable to make the best use and less code to identify the cells.

### Third party frameworks

- Reusable
- SnapKit

## Architecture

The structure to be followed is that of the `feature / view-code` branch, the` Master` branch, contains a standard implementation without libraries and following a pattern without the Coordinators.

I started structuring the project with MVC-C, but then I saw that it would have an approach and would grow better structured with MVVM where I could separate the logic in the ViewModel layer, respecting the principles of design patterns like SRP and Observable. We also have the Coordinators pattern approach, for communication between Controllers segmenting and removing this responsibility from the Controller.

## Requirements

- Xcode 10.2
- Swift 4+

## Improvments

- Implement tests in logic of business layer;
- Implement UI Tests

### Important!!

For application we are providing the keys for testing and general use, but if you wanted to test with your account you need to create an account at [https://developer.marvel.com/]() and register your public key and private key. 
