"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.typeset = exports.loadExtensions = void 0;
const workerpool = __importStar(require("workerpool"));
const mathjax_js_1 = require("mathjax-full/js/mathjax.js");
const tex_js_1 = require("mathjax-full/js/input/tex.js");
const svg_js_1 = require("mathjax-full/js/output/svg.js");
const liteAdaptor_js_1 = require("mathjax-full/js/adaptors/liteAdaptor.js");
const html_js_1 = require("mathjax-full/js/handlers/html.js");
require("mathjax-full/js/input/tex/AllPackages.js");
const adaptor = (0, liteAdaptor_js_1.liteAdaptor)();
(0, html_js_1.RegisterHTMLHandler)(adaptor);
const baseExtensions = ['ams', 'base', 'color', 'newcommand', 'noerrors', 'noundefined'];
function createHtmlConverter(extensions) {
    const baseTexOption = {
        packages: extensions,
        formatError: (_jax, error) => { throw new Error(error.message); }
    };
    const texInput = new tex_js_1.TeX(baseTexOption);
    const svgOption = { fontCache: 'local' };
    const svgOutput = new svg_js_1.SVG(svgOption);
    return mathjax_js_1.mathjax.document('', { InputJax: texInput, OutputJax: svgOutput });
}
let html = createHtmlConverter(baseExtensions);
function loadExtensions(extensions) {
    const extensionsToLoad = baseExtensions.concat(extensions);
    html = createHtmlConverter(extensionsToLoad);
}
exports.loadExtensions = loadExtensions;
function typeset(arg, opts) {
    const convertOption = {
        display: true,
        em: 18,
        ex: 9,
        containerWidth: 80 * 18
    };
    const node = html.convert(arg, convertOption);
    const css = `svg {font-size: ${100 * opts.scale}%;} * { color: ${opts.color} }`;
    let svgHtml = adaptor.innerHTML(node);
    svgHtml = svgHtml.replace(/<defs>/, `<defs><style>${css}</style>`);
    return svgHtml;
}
exports.typeset = typeset;
const workers = { loadExtensions, typeset };
workerpool.worker(workers);
//# sourceMappingURL=mathjaxpool_worker.js.map