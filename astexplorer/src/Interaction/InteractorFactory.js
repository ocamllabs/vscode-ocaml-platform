import BrowserInteractor from './BrowserInteractor';
import VsCodeInteractorFactory from './VsCodeInteractorFactory';

function tryAcquireVsCodeApi() {
  try {
    return acquireVsCodeApi();
  }
  catch { // In this case we are not in VsCode context
    return null;
  }
}

function create() {
  const vsCodeApi = tryAcquireVsCodeApi();

  if (vsCodeApi === null) {
    return BrowserInteractor;
  }
  else {
    return VsCodeInteractorFactory.createFromVsCodeApi(vsCodeApi);
  }
}

const InteractorFactory = {
  create : create
}

export default InteractorFactory;