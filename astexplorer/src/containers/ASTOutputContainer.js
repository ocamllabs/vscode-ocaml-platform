import { connect } from 'react-redux';
import ASTOutput from '../components/ASTOutput';
//import * as selectors from '../store/selectors';
import * as astresult from './test.json'

function mapStateToProps(_state) {
  return {
    parseResult: astresult,
    position: 1,
  };
}

export default connect(mapStateToProps)(ASTOutput);
