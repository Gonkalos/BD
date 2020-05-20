
// 1
db.restaurants.find({})

// 2
db.restaurants.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

// 3
db.restaurants.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0})

// 4
db.restaurants.find({}, {restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1, _id: 0})

// 5
db.restaurants.find({borough: "Bronx"})

// 6
db.restaurants.find({borough: "Bronx"}).limit(5)

// 7
db.restaurants.find({borough: "Bronx"}).skip(5).limit(5)

// 8
db.restaurants.find({"grades.score": {$gt: 90}})

// 9
db.restaurants.find({"grades.score": {$gt: 80, $lt: 100}})

// 10
db.restaurants.find({"address.coord.0": {$lt: -95.754168}})

// 11
db.restaurants.find({cuisine: {$ne: "American "}, "grades.score": {$gt: 70}, "address.coord.0": {$lt: -65.754168}})

// 12
db.restaurants.find({cuisine: {$ne: "American "}, "grades.score": {$gt: 70}, "address.coord.0": {$lt: -65.754168}})

// 13
db.restaurants.find({cuisine: {$ne: "American "}, "grades.grade": {$eq: "A"}, borough: {$ne: "Brooklyn"}}).sort({cuisine: -1})
    
// 14
db.restaurants.find({borough: {$eq:"Bronks"} , cuisine: {$in: ["American ", "Chinese"]}})

// 15
db.restaurants.find({"address.coord": {$type: 1}})

// 16
db.restaurants.find({"address.street": {$exists: true}})

// 17
db.restaurants.find({}).sort({cuisine: 1, borough: -1})

// 18
db.restaurants.find({restaurant_id: 1, name: 1, address: 1}, {"address.coord.1": {$gt: 42, $lt: 52}})

// 19
db.restaurants.find({restaurant_id: 1, name: 1, address: 1, "address.coord": 1}, {"grades.score": {$lt: 11}})

// 20
db.restaurants.find({restaurant_id: 1, name: 1, borough: 1, cuisine: 1}, {borough: {$nin: ["State Island", "Queens", "Bronks", "Broklyn"]}}) 








