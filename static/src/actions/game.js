import {
    RECEIVE_GAME_STATUS,
    REQUEST_GAME_STATUS,
    ERROR_GAME_STATUS,
    REQUEST_START_GAME,
    RECEIVE_START_GAME,
    ERROR_START_GAME,
    REQUEST_PLAY_CARD,
    ERROR_PLAY_CARD,
    REQUEST_END_GAME,
    RECEIVE_END_GAME,
    ERROR_END_GAME,
} from '../constants/index';

export function requestGameStatus() {
    return {
        type: REQUEST_GAME_STATUS,
    };
}

export function requestPlayCard() {
    return {
        type: REQUEST_PLAY_CARD,
    };
}

export function playCardFailed() {
    return {
        type: ERROR_PLAY_CARD,
    };
}

export function receiveGameStatus(payload) {
    return {
        type: RECEIVE_GAME_STATUS,
        payload,
    };
}

export function gameStatusFailed() {
    return {
        type: ERROR_GAME_STATUS,
    };
}

export function checkGameStatus(playerId) {
    return (dispatch) => {
        dispatch(requestGameStatus());
        const token = localStorage.getItem('token');
        fetch(`/api/game/status?player_id=${playerId}`, {
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
            if (body.status === 'Started') {
                dispatch(receiveGameStatus({
                    game: body.game,
                    started: true,
                    completed: false,
                    cardPlayed: false,
                    clearInterval: false,
                }));
            } else if (body.status === 'Card Played') {
                dispatch(receiveGameStatus({
                    game: body.game,
                    started: true,
                    completed: false,
                    cardPlayed: true,
                    clearInterval: false,
                }));
            } else if (body.status === 'Completed') {
                dispatch(receiveGameStatus({
                    game: body.game,
                    started: true,
                    completed: true,
                    cardPlayed: true,
                    clearInterval: true,
                }));
            } else {
                dispatch(receiveGameStatus({
                    game: body.game,
                    started: false,
                    cardPlayed: false,
                    clearInterval: false,
                }));
            }
        })
        .catch((err) => {
            // catch error
            console.error(err);
            dispatch(gameStatusFailed({
                game: null,
                started: false,
                completed: false,
                error: true,
                clearInterval: false,
            }));
        });
    };
}
export function playCard(playerId, cardId, discarded) {
    return (dispatch) => {
        dispatch(requestPlayCard());
        const token = localStorage.getItem('token');
        fetch(`/api/game/play_card?player_id=${playerId}&card_id=${cardId}&discarded=${discarded}&for_wonder=false`, {
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
            if (body.cardplayed) {
                dispatch(playCardFailed({ game: body.game, cardplayed: true }));
            } else {
                dispatch(requestPlayCard({ game: body.game, cardplayed: false }));
            }
        })
        .catch((err) => {
            console.error(err);
            dispatch(playCardFailed({ game: null, error: true }));
        });
    };
}

function requestStartGame() {
    return {
        type: REQUEST_START_GAME,
    };
}

function receiveStartGame(payload) {
    return {
        type: RECEIVE_START_GAME,
        payload,
    };
}

function errorStartGame() {
    return {
        type: ERROR_START_GAME,
    };
}

export function startGame(playerId) {
    return (dispatch) => {
        dispatch(requestStartGame());
        const token = localStorage.getItem('token');
        fetch(`/api/game/start?player_id=${playerId}`, {
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
            dispatch(receiveStartGame({ game: body.game, started: true, players: body.players }));
        })
        .catch((err) => {
            // catch error
            console.error(err);
            dispatch(errorStartGame({ game: null, started: false, error: true }));
        });
    };
}

function requestEndGame() {
    return {
        type: REQUEST_END_GAME,
    };
}

function receiveEndGame(payload) {
    return {
        type: RECEIVE_END_GAME,
        payload,
    };
}

function errorEndGame() {
    return {
        type: ERROR_END_GAME,
    };
}

export function endGame(playerId) {
    return (dispatch) => {
        dispatch(requestEndGame());
        const token = localStorage.getItem('token');
        fetch(`/api/game/end?player_id=${playerId}`, {
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
            dispatch(receiveEndGame({
                completed: true,
                clearInterval: false,
            }));
        })
        .catch((err) => {
            // catch error
            console.error(err);
            dispatch(errorEndGame());
        });
    };
}
