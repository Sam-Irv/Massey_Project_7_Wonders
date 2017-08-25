import React from 'react';
import { RaisedButton } from 'material-ui';
import GameScreen from './GameScreen';
import PlayerDisplay from './PlayerDisplay';

// we must export the class for testing. Then also default export the class
// at the end of the file which is used for the actual production render
export class Play extends React.Component {

    constructor() {
        super();
        this.state = {
            game: false,
            error: false,
            playerId: null,
        };
        this.createGame = this.createGame.bind(this);
    }

    componentDidMount() {
        // check if the user is already part of a game
        const token = localStorage.getItem('token');
        fetch('/api/game/check', {
            method: 'get',
            credentials: 'include',
            headers: {
                'Accept': 'application/json', // eslint-disable-line quote-props
                'Content-Type': 'application/json',
                Authorization: token,
            },
        })
        .then(response => response.json())
        .then((body) => {
            // do something
            console.log(body);
            if (body.player_id) {
                this.setState({
                    game: true,
                    error: false,
                    playerId: body.player_id,
                });
            } else {
                this.setState({
                    game: false,
                    error: false,
                });
            }
        })
        .catch((err) => {
            // catch error
            console.log(err);
            this.setState({
                game: false,
                error: true,
            });
        });
    }

    createGame() {
        // send request to create game
        const token = localStorage.getItem('token');
        fetch('/api/game/create', {
            method: 'get',
            credentials: 'include',
            headers: {
                'Accept': 'application/json', // eslint-disable-line quote-props
                'Content-Type': 'application/json',
                Authorization: token,
            },
        })
        .then(response => response.json())
        .then((body) => {
            // do something
            console.log(body);
            if (body.player_id) {
                this.setState({
                    game: true,
                    error: false,
                    playerId: body.player_id,
                });
            } else {
                this.setState({
                    game: false,
                    error: true,
                });
            }
        })
        .catch((err) => {
            // catch error
            console.log(err);
            this.setState({
                game: false,
                error: true,
            });
        });
    }
    render() {
        const { game, error, playerId } = this.state;
        return (
            <div className="Game col-md-12">
                <h1>Play</h1>

                <hr />
                {error &&
                    <p>There was an error</p>
                }
                {!game &&
                    <RaisedButton
                        label="Create/Join Game"
                        onClick={() => this.createGame()}
                    />
                }
                {game &&
                    <div>
                      <PlayerDisplay playerId={playerId} />
                      <GameScreen playerId={playerId} />
                    </div>
                }
            </div>
        );
    }
}

export default Play;
