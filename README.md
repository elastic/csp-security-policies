# cis-benchmark-pdf-data-serialization
 
The cis-benchmark serialization tool is an internal tool meant for creating the cis benchmark rule metadata.

## Getting started 

### Prerequisites
- node.js version v17.6.0 and above

### Running the project

Install node dependencies `npm install`

Go the `main.js` and edit the following:
- Download the `CIS_Kubernetes_Benchmark_v1.6.0.pdf` file.
- Set the `pdfPath` to your `CIS_Kubernetes_Benchmark_v1.6.0.pdf` file path.
- **Optional** set the B_Page/E_page to the first/last rule page you want to convert.

Run the project `node main.js`
