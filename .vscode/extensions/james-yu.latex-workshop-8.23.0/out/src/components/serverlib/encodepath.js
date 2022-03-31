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
exports.PdfFilePathEncoder = void 0;
const vscode = __importStar(require("vscode"));
class PdfFilePathEncoder {
    constructor(extension) {
        /**
         * Prefix that server.ts uses to distiguish requests on pdf files from others.
         * We use '.' because it is not converted by encodeURIComponent and other functions.
         * See https://stackoverflow.com/questions/695438/safe-characters-for-friendly-url
         * See https://tools.ietf.org/html/rfc3986#section-2.3
         */
        this.pdfFilePrefix = 'pdf..';
        this.extension = extension;
    }
    /**
     * We encode the path with base64url after calling encodeURIComponent.
     * The reason not using base64url directly is that we are not sure that
     * encodeURIComponent, unescape, and btoa trick is valid on node.js.
     * - https://en.wikipedia.org/wiki/Base64#URL_applications
     * - https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/btoa#Unicode_strings
     */
    encodePath(url) {
        const s = encodeURIComponent(url);
        const b64 = Buffer.from(s).toString('base64');
        const b64url = b64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '');
        return b64url;
    }
    decodePath(b64url) {
        const tmp = b64url + '='.repeat((4 - b64url.length % 4) % 4);
        const b64 = tmp.replace(/-/g, '+').replace(/_/g, '/');
        const s = Buffer.from(b64, 'base64').toString();
        return decodeURIComponent(s);
    }
    encodePathWithPrefix(pdfFilePath) {
        return this.pdfFilePrefix + this.encodePath(pdfFilePath.toString(true));
    }
    decodePathWithPrefix(b64urlWithPrefix) {
        const s = b64urlWithPrefix.replace(this.pdfFilePrefix, '');
        const uriString = this.decodePath(s);
        return vscode.Uri.parse(uriString, true);
    }
}
exports.PdfFilePathEncoder = PdfFilePathEncoder;
//# sourceMappingURL=encodepath.js.map