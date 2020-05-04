## Metadata Browser

### Background
The Metadata Browser is a set of pre-defined searches that allow our data curation team to view/compare metadata within and across packages. In order to ensure we don't lose these searches/this dashboard, we have exported the definitions from Kibana.

### Files
| File name   | Description  |
| ------------ | ------------ |
|  ReplicatesDashboard.json | Contains the definition of the dashboard, including which panels to include  |
| ReplicatesBAMFilesView.json  | One of the panels/searches included in the dashboard  |
| ReplicatesExpressionMatrixFilesView.json  |  One of the panels/searches included in the dashboard |
| ReplicatesFASTQFilesView.json  | One of the panels/searches included in the dashboard  |
| metadata-packages-index-pattern.json  | A defined index pattern to help in defining the panels  |
| metadata-replicates-index-pattern.json | A defined index pattern to help in defining the panels  |

### To recreate
I believe these can be reimported either before or after metadata documents have been added to the indexes for viewing inside the Metadata Browser.

You will likely need to start with reimporting the index patterns first, then the \*View files and finally the \*Dashboard file. **This has not been tested**

To import, log into Kibana and navigate to the Management pane (the gear icon at the bottom left). Under the Kibana section, click on Saved Objects. At the top right, you will see "Import". Click this and select the item from above that you need to re-import.

