import React, { PropTypes, Component } from 'react';
import { RaisedButton, CardActions, FlatButton, Card,
    CardHeader, CardText, CardMedia, CardTitle, List,
    Table, TableBody, TableRow, TableRowColumn } from 'material-ui';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as actions from '../actions/game';
import Inventory from './Inventory';

function mapStateToProps(state) {
    return {
        game: state.game.game,
        started: state.game.started,
        error: state.game.error,
        loading: state.game.loading,
        playerCount: state.game.playerCount,
    };
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators(actions, dispatch);
}

export class PlayerDisplay extends Component {

    constructor(props) {
        super(props);
        this.state = {
            userID: null,
            displayID: null,
            userData: null,
        };
        if (this.props.game) {
            // load passed data
            this.state.userID = this.props.game.player.id;
            this.state.displayID = this.props.game.player.id;
            this.state.userData = this.props.game.player;
            // binding
            this.lookLeft = this.lookLeft.bind(this);
            this.lookRight = this.lookRight.bind(this);
            this.lookUser = this.lookUser.bind(this);
            this.search = this.search.bind(this);
        }
    }

    lookLeft() {
        console.log('** CLICKED LEFT **');
        const newDisplayID = this.search().left_id;
        this.setState({
            displayID: newDisplayID,
        });
    }

    lookRight() {
        console.log('** CLICKED RIGHT **');
        this.setState({
            displayID: this.search().right_id,
        });
    }

    lookUser() {
        console.log('** CLICKED View User **');
        this.setState({
            displayID: this.state.userID,
        });
    }

    search() {
        const nameKey = this.state.displayID;
        var data = {};
        if (nameKey === this.state.userID) {
            data = this.state.userData;
        } else {
          const myArray = this.props.game.allPlayers;
          for (var i=0; i < myArray.length; i++) {
              if (myArray[i].id === nameKey) {
                  data = myArray[i];
              }
          }
        }
        return data;
    }

    render() {
        const boardData = this.search();
        console.log("boardData", boardData);
        const { error, game, started } = this.props;
        const ListStyle = {
            width: 100,
            paddingTop: 0,
        };
        const inventorycustomColumnStyle = {
            paddingTop: 0, width: 100 };
        let imageName = '';
        if (true) {
            const longCityNameArray = (boardData.wonder).split(' ');
            const city = longCityNameArray.length - 1;
            imageName = longCityNameArray[city].toLowerCase();
        }
        // creates list of wonders completed to render on board
        var rows = [];
        for (var each = 0; each < boardData.max_wonder; each ++) {
            if (each < boardData.wonder_level) {
                rows.push('Complete');
            } else {
                rows.push(null);
            }
        }
        console.log("WonderList: ", rows);

        return (
            <div>
                {game && !error && started && boardData &&
                    <div>
                        {
                          <div>
                            <Table>
                              <TableBody displayRowCheckbox={false} >
                                <TableRow selectable={false}>
                                  <TableRowColumn width="50" id="leftNav" >
                                    <input type="image" width="20" src='dist/images/icons/left_arrow.png' onClick={this.lookLeft} />
                                  </TableRowColumn>
                                  <TableRowColumn>
                                    <Card
                                        expanded={this.state.expanded}
                                        onExpandChange={this.handleExpandChange}
                                    >
                                        <CardHeader
                                            id="CardHeader"
                                            title={`Player Name (id:${this.state.displayID})`}  // "(Add players Name here)"
                                            subtitle={boardData.wonder}
                                            avatar={`dist/images/cards/age${game.cards[0].age}.png`}               // ${game.cards[0].age}
                                            actAsExpander={true}
                                            showExpandableButton={true}
                                        />
                                        <CardText id="CardText" style={{ paddingBottom: 0, paddingTop: 0 }}>
                                            <div>
                                                <Table>
                                                    <TableBody displayRowCheckbox={false} >
                                                        <TableRow selectable={false}>
                                                            <TableRowColumn
                                                                style={inventorycustomColumnStyle}
                                                            >
                                                                <List style={ListStyle}>
                                                                    <Inventory item="wood" amount={boardData.wood} />
                                                                    <Inventory item="brick" amount={boardData.brick} />
                                                                    <Inventory item="ore" amount={boardData.ore} />
                                                                    <Inventory item="stone" amount={boardData.stone} />
                                                                    <Inventory item="glass" amount={boardData.glass} />
                                                                    <Inventory item="paper" amount={boardData.paper} />
                                                                    <Inventory item="cloth" amount={boardData.cloth} />
                                                                </List>
                                                            </TableRowColumn>
                                                            <TableRowColumn>
                                                                <CardActions>
                                                                    <FlatButton label="Back to your Wonder" onClick={this.lookUser} />
                                                                </CardActions>
                                                                <CardMedia
                                                                    overlay={<CardTitle subtitle="Player thinking..." />}
                                                                >
                                                                    <img alt="" src={`dist/images/cities/${imageName}A.png`} />
                                                                </CardMedia>
                                                                <Table
                                                                    id="wonderTable"
                                                                    style={{ marginLeft:10, marginRight: 10 }}>
                                                                    <TableBody
                                                                        displayRowCheckbox={false}
                                                                    >
                                                                        <TableRow>
                                                                            {
                                                                                rows.map((wCard) => {
                                                                                    console.log(wCard);
                                                                            if (wCard) {
                                                                              return (
                                                                                  <TableRowColumn style={{ padding: 0}}>
                                                                                  <center>
                                                                                          <img width="150" alt="Complete" src={'dist/images/icons/wonderCard.png'} />
                                                                                  </center>
                                                                                  </TableRowColumn>
                                                                              );
                                                                            } else {
                                                                              return (
                                                                                <TableRowColumn style={{ padding: 0 }}>

                                                                                </TableRowColumn>
                                                                            )
                                                                            }
                                                                        })

                                                                      }
                                                                    </TableRow>
                                                                  </TableBody>
                                                                </Table>
                                                            </TableRowColumn>
                                                            <TableRowColumn
                                                                style={inventorycustomColumnStyle}
                                                            >
                                                                <List style={ListStyle}>
                                                                    <Inventory item="vp" amount={boardData.points} />
                                                                    <Inventory item="coin" amount={boardData.money} />
                                                                    <Inventory item="pyramid-stage0" amount={boardData.wonder_level} />
                                                                    <br />
                                                                    <Inventory item="military" amount={boardData.military} />
                                                                    <Inventory item="victoryminus1" amount={0} />

                                                                </List>
                                                            </TableRowColumn>
                                                            <TableRowColumn
                                                                style={inventorycustomColumnStyle}
                                                            >
                                                                <List id="buildings" style={ListStyle}>
                                                                    <Inventory item="cog" amount={boardData.cog} />
                                                                    <Inventory item="tablet" amount={boardData.tablet} />
                                                                    <Inventory item="compass" amount={boardData.compass} />
                                                                    <Inventory item="commercial" amount={0} />
                                                                    <Inventory item="civillian" amount={0} />
                                                                </List>
                                                            </TableRowColumn>
                                                        </TableRow>
                                                    </TableBody>
                                                </Table>
                                            </div>
                                        </CardText>
                                        <CardText id="played cards" expandable={true}>
                                            <hr />
                                            <h3>All Cards Played for Wonder</h3>
                                            <p><i>
                                                Card 1, Card 2...
                                            </i></p>
                                        </CardText>

                                    </Card>
                                  </TableRowColumn>
                                  <TableRowColumn width="50" id="rightNav" >
                                    <input type="image" width="20" src='dist/images/icons/right_arrow.png' onClick={this.lookRight} />
                                  </TableRowColumn>
                                </TableRow>
                              </TableBody>
                            </Table>
                          </div>
                          }
                        <hr />
                    </div>
                }
            </div>
        );
    }
}

PlayerDisplay.propTypes = {
    game: PropTypes.object,
    started: PropTypes.bool.isRequired,
    playerId: PropTypes.number.isRequired,

};

PlayerDisplay.defaultProps = {
    game: null,
    playerCount: null,
};

export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(PlayerDisplay);
