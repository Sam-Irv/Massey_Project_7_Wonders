import React, { PropTypes, Component } from 'react';
import { RaisedButton, CardActions, FlatButton, Card,CardHeader, CardText, CardMedia, CardTitle } from 'material-ui';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as actions from '../actions/game';
import { poll } from '../utils/misc';
import Toggle from 'material-ui/Toggle';
import {List, ListItem} from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import Subheader from 'material-ui/Subheader';
import {
  Table,
  TableBody,
  TableHeader,
  TableHeaderColumn,
  TableRow,
  TableRowColumn,
} from 'material-ui/Table';


class CardExampleControlled extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      expanded: false,
    };
  }

  handleExpandChange = (expanded) => {
    this.setState({expanded: expanded});
  };

  handleToggle = (event, toggle) => {
    this.setState({expanded: toggle});
  };

  handleExpand = () => {
    this.setState({expanded: true});
  };

  handleReduce = () => {
    this.setState({expanded: false});
  };
}


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

class TableExampleComplex extends Component {
  state = {
    showCheckboxes: false,
    selectable: false,
  };
}

export class PlayerDisplay extends Component {

    constructor() {
        super();
        this.state = {
            polling: false,
        };
        this.startGame = this.startGame.bind(this);
        this.pollGameStatus = this.pollGameStatus.bind(this);
    }

    componentDidMount() {
        this.props.checkGameStatus(this.props.playerId);
    }

    componentWillReceiveProps(nextProps) {
        if (nextProps.started && !this.state.polling) {
            this.setState({
                polling: true,
            });
            this.pollGameStatus();
        }
    }

    pollGameStatus() {
        poll(() => this.props.checkGameStatus(this.props.playerId), 5000);
    }

    startGame() {
        this.props.startGame(this.props.playerId);
    }

    render() {
        const { error, game, started, playerCount } = this.props;

        return (
            <div>
                {game && !error && started &&
                  <div>
                      {
                          <Card expanded={this.state.expanded} onExpandChange={this.handleExpandChange} >
                            <CardHeader
                              title= "Players Name here"
                              subtitle={game.player.wonder}
                              avatar={`dist/images/cities/rhodosA.png`}
                              actAsExpander={true}
                              showExpandableButton={true}
                            />
                            <CardText>
                              <div>
                                <Table>
                                  <TableBody displayRowCheckbox={false}>
                                    <TableRow>
                                      <TableRowColumn>
                                        <List>
                                          <Subheader>Inventory</Subheader>
                                            <Inventory item="wood" amount={game.player.wood} />
                                            <Inventory item="brick" amount={game.player.brick} />
                                            <Inventory item="ore" amount={game.player.ore} />
                                            <Inventory item="stone" amount={game.player.stone} />
                                            <Inventory item="glass" amount={game.player.glass} />
                                            <Inventory item="paper" amount={game.player.paper} />
                                            <Inventory item="cloth" amount={game.player.cloth} />
                                        </List>
                                      </TableRowColumn>
                                      <TableRowColumn>
                                        <List>
                                          <Subheader>Buildings</Subheader>

                                        </List>
                                      </TableRowColumn>
                                      <TableRowColumn>
                                        <List>
                                          <Subheader>VP Coin Military</Subheader>
                                          <Inventory item="vp" amount={game.player.points} />
                                          <Inventory item="coin" amount={game.player.money} />
                                          <Inventory item="military" amount={game.player.military} />
                                        </List>
                                      </TableRowColumn>
                                    </TableRow>
                                  </TableBody>
                                </Table>
                              </div>

                            </CardText>
                            <CardMedia
                              expandable={true}
                              overlay={<CardTitle subtitle="This is maybe how we show which wonder card has been played by a Tick image" />}
                              >
                              <img src={`dist/images/cities/rhodosA.png`} alt="" />
                            </CardMedia>
                            <CardText expandable={false}>

                            </CardText>

                            <CardActions>
                              <FlatButton label="<< View Left Player" />
                              <FlatButton labelPosition="before" label="View Right Player >>" />
                            </CardActions>

                          </Card>
                  }
                  <hr />
                  </div>

                }
                {!error && !game && !started &&
                    <RaisedButton
                        label="I am ready"
                        onClick={() => this.startGame()}
                    />
                }
                {!error && !game &&
                    <p>Waiting on more players... {state.game.playerCount} players so far.</p>
                }
                {error &&
                    <p>There was an error</p>
                }
            </div>
        );
    }
}

function CityBoard(props) {
  return (
    <div>
		<img src={baseLocation + `../images/cities/${props.name}.png`} />
		<center><h3>City: {props.name}</h3></center>
    </div>
    );
}

function Player(props) {
   return <div>
      <center><h1>Player: {props.player} <i> (ID: {props.ID}) </i></h1></center>
      </div>;
}

function Inventory (props) {
   return(
     <ListItem
       primaryText={props.amount.toString()}
       leftAvatar={<Avatar height="20" src={`dist/images/icons/${props.item}.png`} />}
       /> )
}

PlayerDisplay.propTypes = {
    checkGameStatus: PropTypes.func.isRequired,
    startGame: PropTypes.func.isRequired,
    error: PropTypes.bool.isRequired,
    game: PropTypes.object,
    started: PropTypes.bool.isRequired,
    loading: PropTypes.bool.isRequired,
    playerId: PropTypes.number,
    playerCount: PropTypes.number,
};

export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(PlayerDisplay);
