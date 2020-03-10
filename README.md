# Marvel App

This application is intended to list Super Heroes being presented on [Marvel API](https://developer.marvel.com/)

## Architecture

- I started structuring the project with MVC, but then I saw that it would have an approach and grow better structured with MVVM where I could separate a logic in the ViewModel layer, respecting the principles of design patterns like SRP and Observable;
- The ViewModel is differente on all architectures MVVM because she doesn't have business logic, her responsability is only abstract the business model data into a struct that only makes sense to presentation layer.
- Have some improviments on directional flow ( Coordinator -> ViewController -> Interactor -> Presenter )

## Enviroment

- Xcode 10.3
- Swift 4
- No libs

## Improvments

- Add more tests units 

## Important!!

For application we are providing the keys for testing and general use, but if you wanted to test with your account you need to create an account at [https://developer.marvel.com/]() and register your public key and private key. 
