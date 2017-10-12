import React, { PropTypes } from 'react';
import { Table, TableBody, TableRow, TableRowColumn } from 'material-ui';

function Wonder(props) {
    const { boardData } = props;
    var rows = [];
    for (var each = 0; each < boardData.max_wonder; each ++) {
        if (each < boardData.wonder_level) {
            rows.push('Complete');
        } else {
            rows.push(null);
        }
    }

    return (
        <Table
            id="wonderTable"
            style={{ marginLeft: 10, marginRight: 10 }} >
            <TableBody
                displayRowCheckbox={false}
            >
                <TableRow>
                    {
                        rows.map((wCard, index) => {
                            if (wCard) {
                                return (
                                    <TableRowColumn key={wCard} style={{ padding: 0 }} >
                                        <center>
                                            <img width="150" alt="Complete" src={'dist/images/icons/wonderCard.png'} />
                                        </center>
                                    </TableRowColumn>
                                );
                            } else {
                                return (
                                    <TableRowColumn key={index} style={{ padding: 0 }} />
                                );
                            }
                        })

              }
                </TableRow>
            </TableBody>
        </Table>
    );
}

Wonder.propTypes = {
    boardData: PropTypes.object.isRequired,
};

export default Wonder;
