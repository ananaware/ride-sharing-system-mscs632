"RideSharing System - Smalltalk version
 Classes:
   - Ride (abstract)
   - StandardRide
   - PremiumRide
   - Driver
   - Rider
 Demonstrates encapsulation, inheritance, and polymorphism.
"

" CLASS DEFINITIONS "

Object subclass: #Ride
    instanceVariableNames: 'rideId pickupLocation dropoffLocation distanceMiles fareTotal'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

Object subclass: #Driver
    instanceVariableNames: 'driverId driverName driverRating completedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

Object subclass: #Rider
    instanceVariableNames: 'riderId riderName rideHistory'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!


"RIDE METHODS  "

Ride methodsFor: 'initialization'!

initializeWithId: anId
    pickup: pickup
    dropoff: dropoff
    distance: dist
    "Initialize a ride with basic information."
    rideId := anId.
    pickupLocation := pickup.
    dropoffLocation := dropoff.
    distanceMiles := dist.
    fareTotal := 0.0.!

!

Ride methodsFor: 'api'!

computeFare
    "Abstract method - subclasses must implement."
    self subclassResponsibility.!

printRideDetails
    "Abstract method - subclasses must implement."
    self subclassResponsibility.!

rideId
    ^ rideId.!

distanceMiles
    ^ distanceMiles.!

fareTotal
    ^ fareTotal.!

fareTotal: aNumber
    fareTotal := aNumber.!

!


"  STANDARD RIDE METHODS  "

StandardRide methodsFor: 'api'!

computeFare
    "Simple fare formula for standard rides."
    | baseFare perMile total |
    baseFare := 1.5.
    perMile := 1.8.
    total := baseFare + (perMile * distanceMiles).
    self fareTotal: total.
    ^ total.!

printRideDetails
    Transcript
        show: '[Standard] Ride ID: ', rideId printString;
        show: ' | From: ', pickupLocation;
        show: ' | To: ', dropoffLocation;
        show: ' | Distance: ', distanceMiles printString, ' miles';
        show: ' | Fare: $', fareTotal printString;
        cr.!

!


"  PREMIUM RIDE METHODS "

PremiumRide methodsFor: 'api'!

computeFare
    "Premium ride has higher rate and a luxury fee."
    | baseFare perMile luxuryFee total |
    baseFare := 4.0.
    perMile := 3.2.
    luxuryFee := 1.5.
    total := baseFare + (perMile * distanceMiles) + luxuryFee.
    self fareTotal: total.
    ^ total.!

printRideDetails
    Transcript
        show: '[Premium]  Ride ID: ', rideId printString;
        show: ' | From: ', pickupLocation;
        show: ' | To: ', dropoffLocation;
        show: ' | Distance: ', distanceMiles printString, ' miles';
        show: ' | Fare: $', fareTotal printString;
        cr.!

!


"  DRIVER METHODS  "

Driver methodsFor: 'initialization'!

initializeWithId: anId
    name: aName
    rating: aRating
    driverId := anId.
    driverName := aName.
    driverRating := aRating.
    completedRides := OrderedCollection new.!

!

Driver methodsFor: 'api'!

addCompletedRide: aRide
    "Encapsulated modification of completedRides."
    completedRides add: aRide.!

printDriverInfo
    Transcript
        show: 'Driver ID: ', driverId printString;
        show: ' | Name: ', driverName;
        show: ' | Rating: ', driverRating printString;
        show: ' | Total rides: ', completedRides size printString;
        cr.!

totalEarnings
    | sum |
    sum := 0.0.
    completedRides do: [:ride | sum := sum + ride fareTotal ].
    ^ sum.!

!


"  RIDER METHODS  "

Rider methodsFor: 'initialization'!

initializeWithId: anId
    name: aName
    riderId := anId.
    riderName := aName.
    rideHistory := OrderedCollection new.!

!

Rider methodsFor: 'api'!

requestRide: aRide
    "Encapsulated modification of rideHistory."
    rideHistory add: aRide.!

printRideHistory
    Transcript
        show: 'Rider ID: ', riderId printString;
        show: ' | Name: ', riderName;
        cr.
    Transcript show: 'Ride history:'; cr.
    rideHistory do: [:ride | ride printRideDetails ].!

averageFare
    rideHistory isEmpty ifTrue: [ ^ 0.0 ].
    | sum |
    sum := 0.0.
    rideHistory do: [:ride | sum := sum + ride fareTotal ].
    ^ sum / rideHistory size.!

!
