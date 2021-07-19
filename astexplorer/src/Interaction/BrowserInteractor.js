import Interactor from "./Interactor";

Interactor.showInformationMessage = text => alert(text);
Interactor.getDirectoryInfo = callback => callback('Directory: C:\\somewhere\\somedir\\ \n SomeFile.sql, SomeOtherFile.sql')

export default Interactor;