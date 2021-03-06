/* global describe, test, expect */

import React from 'react';
import { shallow } from 'enzyme';
import { FlatButton } from 'material-ui'
import { EndScreen } from '../../src/components/EndScreen';
import { EndGameMarkup } from '../../src/components/EndGameMarkup';


describe('Component: EndScreen', () => {
    const minProps = {
        endOfRound: true,
        open: true,
        hideScoreboard: () => {},
        displayData: { wonder_level: 0, userId: 1, points: 1, military: 1, profile: 'a' },
        game: { allPlayers: { wonder_level: 0, userId: 1, points: 1, military: 1, profile: 'a' },
            game: { age: 1, completed: false, id: 1, round: 1, started: true },
            player: { wonder_level: 0, userId: 1, points: 1, military: 1, profile: 'a' }
        },
    };
    const wrapper = shallow(<EndScreen {...minProps} />);
    test('render without exploding', () => {
        expect(wrapper.find('.Results').length).toEqual(1);
    });
});
