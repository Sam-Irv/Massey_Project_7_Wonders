import React, { Component } from 'react';
import { browserHistory } from 'react-router';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import AppBar from 'material-ui/AppBar';
import LeftNav from 'material-ui/Drawer';
import MenuItem from 'material-ui/MenuItem';
import FlatButton from 'material-ui/FlatButton';
import Divider from 'material-ui/Divider';

import * as actionCreators from '../../actions/auth';

function mapStateToProps(state) {
    return {
        token: state.auth.token,
        userName: state.auth.userName,
        isAuthenticated: state.auth.isAuthenticated,
        userData: state.data,
    };
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators(actionCreators, dispatch);
}

export class Header extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            open: false,
            email: null,
        };
    }

    dispatchNewRoute(route) {
        browserHistory.push(route);
        this.setState({
            open: false,
        });
    }


    handleClickOutside() {
        this.setState({
            open: false,
        });
    }


    logout(e) {
        e.preventDefault();
        this.props.logoutAndRedirect();
        this.setState({
            open: false,
        });
    }

    openNav() {
        this.setState({
            open: true,
        });
    }

    render() {
        const profileName = this.props.userData.data.profile;
        return (
            <header>
                <LeftNav className="Nav-Drawer" containerClassName={this.state.open ? 'open' : ''} open={this.state.open}>
                    {
                        !this.props.isAuthenticated ?
                            <div>
                                <MenuItem onTouchTap={() => this.dispatchNewRoute('/home')}>
                                    <img
                                        alt="logo"
                                        width="200"
                                        src={`dist/images/background/7w_logo.png`}
                                    />
                                </MenuItem>
                                <Divider />
                                <MenuItem onTouchTap={() => this.dispatchNewRoute('/login')}>
                                    Login
                                </MenuItem>
                                <MenuItem onTouchTap={() => this.dispatchNewRoute('/register')}>
                                    Register
                                </MenuItem>
                            </div>
                            :
                            <div>
                                <MenuItem onTouchTap={() => this.dispatchNewRoute('/play')}>
                                    <img
                                        alt="logo"
                                        width="200"
                                        src={`dist/images/background/7w_logo.png`}
                                    />
                                </MenuItem>
                                <MenuItem onTouchTap={() => this.dispatchNewRoute('/home')}>
                                    <i>Signed in ({ profileName })</i>
                                </MenuItem>
                                <Divider />
                                <MenuItem
                                    id="PlayButton"
                                    onTouchTap={() => this.dispatchNewRoute('/play')}
                                >
                                    <b>Play</b>
                                </MenuItem>
                                <Divider />
                                <MenuItem onTouchTap={() => this.dispatchNewRoute('/instructions')}>
                                    How to Play
                                </MenuItem>
                                <Divider />
                                <MenuItem onTouchTap={() => this.dispatchNewRoute('/home')}>
                                    Home
                                </MenuItem>
                                <Divider />
                                <MenuItem
                                    id="LogoutButton"
                                    onTouchTap={(e) => this.logout(e)}
                                >
                                    <i>Logout</i>
                                </MenuItem>
                            </div>
                    }
                </LeftNav>
                <AppBar
                    title="7 Wonders"
                    className="Nav"
                    onLeftIconButtonTouchTap={() => this.openNav()}
                    iconElementRight={
                      !this.props.userName ?
                          <FlatButton label="Home" onTouchTap={() => this.dispatchNewRoute('/')} />
                        :
                          <div>
                              <FlatButton style={{ color: 'white', margin: 9 }} label={`Signed in (${profileName})`} onTouchTap={() => this.dispatchNewRoute('/home')} />
                              <FlatButton style={{ color: 'white', margin: 9 }} label="Home" onTouchTap={() => this.dispatchNewRoute('/')} />
                          </div>

                    }
                />
            </header>

        );
    }
}

Header.propTypes = {
    logoutAndRedirect: React.PropTypes.func,
    isAuthenticated: React.PropTypes.bool,
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(Header);
