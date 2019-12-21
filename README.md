
# Bowling Game

##### Coding example of a Bowling Game using traditional scoring rules. Details in [https://en.wikipedia.org/wiki/Ten-pin_bowling](https://en.wikipedia.org/wiki/Ten-pin_bowling)

### Configuration

#### Dependencies

*  [Ruby 2.6.3](http://ruby-doc.org)

*  [Rails 6.0.2](http://rubyonrails.org)

*  [PostgreSQL 12](https://www.postgresql.org)  
  
 ### Installation
 
```
# Clone the repo
git clone https://github.com/pecavalheiro/bowling

# Install the dependencies
bundle install

# Database steps
rake db:create
rake db:migrate

```

### Running

To execute the project, run the following command in your terminal:

```
bundle exec rails s
```
This will run the web app and allow access to it in `localhost:3000`


### Workflow and Endpoints

#### Create a new game

Used to start a new game with 1 or 2 players. Only the first player name is required, the second is optional (in case of a single player game).

Example usage:
```
→ curl -X POST http://localhost:3000/games --data '{"game": { "player_1": "John Doe", "player_2": "Jane Doe"  } }' --header "Content-Type: application/json"

Status-code 201 (Created)
(empty body)
```

#### New ball throw

Used to throw a new ball in the current game. Can be attach to a sensor that reads the amount of knocked pins at every round.

Example usage:
```
→  curl -X POST -v http://localhost:3000/game/throws --data '{"knocked_pins": 5 }' --header "Content-Type: application/json"

Status-code 200 (Ok)
(empty body)
```

#### Current game status

Used to fetch the status of the current game.

Example usage:
```
→  curl -X GET -v http://localhost:3000/games --header "Content-Type: application/json"

Status-code 200 (Ok)

{
	"data": {
		"id": "14",
		"type": "game",
		"attributes": {
			"player_1_score": 10,
			"player_2_score": 0
		},
		"relationships": {
			"frames": {
				"data": [{
					"id": "211",
					"type": "frame"
				}, {
					"id": "212",
					"type": "frame"
				}, {
					"id": "213",
					"type": "frame"
				}, {
					"id": "214",
					"type": "frame"
				}, {
					"id": "215",
					"type": "frame"
				}, {
					"id": "216",
					"type": "frame"
				}, {
					"id": "217",
					"type": "frame"
				}, {
					"id": "218",
					"type": "frame"
				}, {
					"id": "219",
					"type": "frame"
				}, {
					"id": "220",
					"type": "frame"
				}, {
					"id": "221",
					"type": "frame"
				}, {
					"id": "222",
					"type": "frame"
				}, {
					"id": "223",
					"type": "frame"
				}, {
					"id": "224",
					"type": "frame"
				}, {
					"id": "225",
					"type": "frame"
				}, {
					"id": "226",
					"type": "frame"
				}, {
					"id": "227",
					"type": "frame"
				}, {
					"id": "228",
					"type": "frame"
				}, {
					"id": "229",
					"type": "frame"
				}, {
					"id": "230",
					"type": "frame"
				}]
			}
		}
	},
	"included": [{
		"id": "211",
		"type": "frame",
		"attributes": {
			"number": 1,
			"player_id": 1,
			"ball_1": 10,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 10
		}
	}, {
		"id": "212",
		"type": "frame",
		"attributes": {
			"number": 2,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "213",
		"type": "frame",
		"attributes": {
			"number": 3,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "214",
		"type": "frame",
		"attributes": {
			"number": 4,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "215",
		"type": "frame",
		"attributes": {
			"number": 5,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "216",
		"type": "frame",
		"attributes": {
			"number": 6,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "217",
		"type": "frame",
		"attributes": {
			"number": 7,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "218",
		"type": "frame",
		"attributes": {
			"number": 8,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "219",
		"type": "frame",
		"attributes": {
			"number": 9,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "220",
		"type": "frame",
		"attributes": {
			"number": 10,
			"player_id": 1,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "221",
		"type": "frame",
		"attributes": {
			"number": 1,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "222",
		"type": "frame",
		"attributes": {
			"number": 2,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "223",
		"type": "frame",
		"attributes": {
			"number": 3,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "224",
		"type": "frame",
		"attributes": {
			"number": 4,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "225",
		"type": "frame",
		"attributes": {
			"number": 5,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "226",
		"type": "frame",
		"attributes": {
			"number": 6,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "227",
		"type": "frame",
		"attributes": {
			"number": 7,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "228",
		"type": "frame",
		"attributes": {
			"number": 8,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "229",
		"type": "frame",
		"attributes": {
			"number": 9,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}, {
		"id": "230",
		"type": "frame",
		"attributes": {
			"number": 10,
			"player_id": 2,
			"ball_1": null,
			"ball_2": null,
			"ball_extra": null,
			"total_points": 0
		}
	}]
}
```

#### Assumptions and expected behaviors
-	When a game does not exist, the app will return code 404 (Not found) when trying to throw a ball
-	When the game has already ended, any new throws will result in a response code 403 (Forbidden)

