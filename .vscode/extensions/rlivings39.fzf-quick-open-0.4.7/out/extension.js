'use strict';
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.makeSearchCmd = exports.deactivate = exports.activate = exports.rgflagmap = exports.rgoptions = exports.TERMINAL_NAME_PWD = exports.TERMINAL_NAME = void 0;
const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const net = require("net");
const os = require("os");
const cp = require("child_process");
let fzfTerminal = undefined;
let fzfTerminalPwd = undefined;
let findCmd;
let fzfCmd;
let initialCwd;
let rgFlags;
let fzfPipe;
let fzfPipeScript;
let windowsNeedsEscape = false;
let fzfQuote = "'";
exports.TERMINAL_NAME = "fzf terminal";
exports.TERMINAL_NAME_PWD = "fzf pwd terminal";
var rgoptions;
(function (rgoptions) {
    rgoptions["CaseSensitive"] = "Case sensitive";
    rgoptions["IgnoreCase"] = "Ignore case";
    rgoptions["SmartCase"] = "Smart case";
})(rgoptions = exports.rgoptions || (exports.rgoptions = {}));
exports.rgflagmap = new Map([
    [rgoptions.CaseSensitive, "--case-sensitive"],
    [rgoptions.IgnoreCase, "--ignore-case"],
    [rgoptions.SmartCase, "--smart-case"]
]);
function showFzfTerminal(name, fzfTerminal) {
    if (!fzfTerminal) {
        // Look for an existing terminal
        fzfTerminal = vscode.window.terminals.find((term) => { return term.name === name; });
    }
    if (!fzfTerminal) {
        // Create an fzf terminal
        if (!initialCwd && vscode.window.activeTextEditor) {
            initialCwd = path.dirname(vscode.window.activeTextEditor.document.fileName);
        }
        initialCwd = initialCwd || '';
        fzfTerminal = vscode.window.createTerminal({
            cwd: initialCwd,
            name: name
        });
    }
    fzfTerminal.show();
    return fzfTerminal;
}
function moveToPwd(term) {
    if (vscode.window.activeTextEditor) {
        let cwd = path.dirname(vscode.window.activeTextEditor.document.fileName);
        term.sendText(`cd ${cwd}`);
    }
}
function applyConfig() {
    var _a, _b, _c, _d, _e, _f;
    let cfg = vscode.workspace.getConfiguration('fzf-quick-open');
    fzfCmd = (_a = cfg.get('fuzzyCmd')) !== null && _a !== void 0 ? _a : "fzf";
    findCmd = cfg.get('findDirectoriesCmd');
    initialCwd = cfg.get('initialWorkingDirectory');
    let rgopt = cfg.get('ripgrepSearchStyle');
    rgFlags = ((_b = exports.rgflagmap.get(rgopt)) !== null && _b !== void 0 ? _b : "--case-sensitive") + ' ';
    rgFlags += (_c = cfg.get('ripgrepOptions')) !== null && _c !== void 0 ? _c : "";
    rgFlags = rgFlags.trim();
    if (isWindows()) {
        let term = vscode.workspace.getConfiguration('terminal.integrated.shell').get('windows');
        // support for new terminal profiles
        if (!term) {
            let defaultTerm = vscode.workspace.getConfiguration('terminal.integrated.defaultProfile').get('windows');
            if (!!defaultTerm) {
                let profiles = vscode.workspace.getConfiguration('terminal.integrated.profiles').get('windows');
                term = (_e = (_d = profiles === null || profiles === void 0 ? void 0 : profiles[defaultTerm]) === null || _d === void 0 ? void 0 : _d.path) === null || _e === void 0 ? void 0 : _e[0];
            }
        }
        let isWindowsCmd = (_f = ((term === null || term === void 0 ? void 0 : term.toLowerCase().endsWith("cmd.exe")) || (term === null || term === void 0 ? void 0 : term.toLowerCase().endsWith("powershell.exe")))) !== null && _f !== void 0 ? _f : false;
        windowsNeedsEscape = !isWindowsCmd;
        // CMD doesn't support single quote.
        fzfQuote = isWindowsCmd ? '"' : "'";
    }
}
function isWindows() {
    return process.platform === 'win32';
}
function getPath(arg, pwd) {
    if (!path.isAbsolute(arg)) {
        arg = path.join(pwd, arg);
    }
    if (fs.existsSync(arg)) {
        return arg;
    }
    else {
        return undefined;
    }
}
function escapeWinPath(origPath) {
    if (isWindows() && windowsNeedsEscape) {
        return origPath === null || origPath === void 0 ? void 0 : origPath.replace(/\\/g, '\\\\');
    }
    else {
        return origPath;
    }
}
function getFzfCmd() {
    return fzfCmd;
}
function getCodeOpenFileCmd() {
    return `${getFzfCmd()} | ${getFzfPipeScript()} open ${getFzfPipe()}`;
}
function getCodeOpenFolderCmd() {
    return `${getFzfCmd()} | ${getFzfPipeScript()} add ${getFzfPipe()}`;
}
function getFindCmd() {
    return findCmd;
}
function getFzfPipe() {
    let res = fzfPipe;
    if (res) {
        res = escapeWinPath(res);
    }
    return res;
}
function getFzfPipeScript() {
    return escapeWinPath(fzfPipeScript);
}
function getQuote() {
    return fzfQuote;
}
function processCommandInput(data) {
    let [cmd, pwd, arg] = data.toString().trim().split('$$');
    cmd = cmd.trim();
    pwd = pwd.trim();
    arg = arg.trim();
    if (arg === "") {
        return;
    }
    if (cmd === 'open') {
        let filename = getPath(arg, pwd);
        if (!filename) {
            return;
        }
        vscode.window.showTextDocument(vscode.Uri.file(filename));
    }
    else if (cmd === 'add') {
        let folder = getPath(arg, pwd);
        if (!folder) {
            return;
        }
        vscode.workspace.updateWorkspaceFolders(vscode.workspace.workspaceFolders ? vscode.workspace.workspaceFolders.length : 0, null, {
            uri: vscode.Uri.file(folder)
        });
        vscode.commands.executeCommand('workbench.view.explorer');
    }
    else if (cmd === 'rg') {
        let [file, linestr, colstr] = arg.split(':');
        let filename = getPath(file, pwd);
        if (!filename) {
            return;
        }
        ;
        let line = parseInt(linestr) - 1;
        let col = parseInt(colstr) - 1;
        vscode.window.showTextDocument(vscode.Uri.file(filename)).then((ed) => {
            let start = new vscode.Position(line, col);
            ed.selection = new vscode.Selection(start, start);
            ed.revealRange(new vscode.Range(start, start));
        });
    }
}
function listenToFifo(fifo) {
    fs.open(fifo, fs.constants.O_RDONLY | fs.constants.O_NONBLOCK, (err, fd) => {
        const pipe = new net.Socket({ fd: fd, allowHalfOpen: true });
        pipe.on('data', (data) => {
            processCommandInput(data);
        });
        pipe.on('end', () => {
            listenToFifo(fifo);
        });
    });
}
function setupWindowsPipe() {
    let server = net.createServer((socket) => {
        socket.on('data', (data) => {
            processCommandInput(data);
        });
    });
    let idx = 0;
    while (!fzfPipe) {
        try {
            let pipe = `\\\\?\\pipe\\fzf-pipe-${process.pid}`;
            if (idx > 0) {
                pipe += `-${idx}`;
            }
            server.listen(pipe);
            fzfPipe = pipe;
        }
        catch (e) {
            if (e.code === 'EADDRINUSE') {
                // Try again for a new address
                ++idx;
            }
            else {
                // Bad news
                throw e;
            }
        }
    }
}
function setupPOSIXPipe() {
    let idx = 0;
    while (!fzfPipe && idx < 10) {
        try {
            let pipe = path.join(os.tmpdir(), `fzf-pipe-${process.pid}`);
            if (idx > 0) {
                pipe += `-${idx}`;
            }
            cp.execSync(`mkfifo -m 600 ${pipe}`);
            fzfPipe = pipe;
        }
        catch (e) {
            // Try again for a new address
            ++idx;
        }
    }
    listenToFifo(fzfPipe);
}
function setupPipesAndListeners() {
    if (isWindows()) {
        setupWindowsPipe();
    }
    else {
        setupPOSIXPipe();
    }
}
function activate(context) {
    var _a, _b;
    applyConfig();
    setupPipesAndListeners();
    fzfPipeScript = (_b = (_a = vscode.extensions.getExtension('rlivings39.fzf-quick-open')) === null || _a === void 0 ? void 0 : _a.extensionPath) !== null && _b !== void 0 ? _b : "";
    fzfPipeScript = path.join(fzfPipeScript, 'scripts', 'topipe.' + (isWindows() ? "bat" : "sh"));
    vscode.workspace.onDidChangeConfiguration((e) => {
        if (e.affectsConfiguration('fzf-quick-open') || e.affectsConfiguration('terminal.integrated.shell.windows')) {
            applyConfig();
        }
    });
    context.subscriptions.push(vscode.commands.registerCommand('fzf-quick-open.runFzfFile', () => {
        let term = showFzfTerminal(exports.TERMINAL_NAME, fzfTerminal);
        term.sendText(getCodeOpenFileCmd(), true);
    }));
    context.subscriptions.push(vscode.commands.registerCommand('fzf-quick-open.runFzfFilePwd', () => {
        let term = showFzfTerminal(exports.TERMINAL_NAME_PWD, fzfTerminalPwd);
        moveToPwd(term);
        term.sendText(getCodeOpenFileCmd(), true);
    }));
    context.subscriptions.push(vscode.commands.registerCommand('fzf-quick-open.runFzfAddWorkspaceFolder', () => {
        let term = showFzfTerminal(exports.TERMINAL_NAME, fzfTerminal);
        term.sendText(`${getFindCmd()} | ${getCodeOpenFolderCmd()}`, true);
    }));
    context.subscriptions.push(vscode.commands.registerCommand('fzf-quick-open.runFzfAddWorkspaceFolderPwd', () => {
        let term = showFzfTerminal(exports.TERMINAL_NAME_PWD, fzfTerminalPwd);
        moveToPwd(term);
        term.sendText(`${getFindCmd()} | ${getCodeOpenFolderCmd()}`, true);
    }));
    context.subscriptions.push(vscode.commands.registerCommand('fzf-quick-open.runFzfSearch', () => __awaiter(this, void 0, void 0, function* () {
        let pattern = yield getSearchText();
        if (pattern === undefined) {
            return;
        }
        let term = showFzfTerminal(exports.TERMINAL_NAME, fzfTerminal);
        term.sendText(makeSearchCmd(pattern), true);
    })));
    context.subscriptions.push(vscode.commands.registerCommand('fzf-quick-open.runFzfSearchPwd', () => __awaiter(this, void 0, void 0, function* () {
        let pattern = yield getSearchText();
        if (pattern === undefined) {
            return;
        }
        let term = showFzfTerminal(exports.TERMINAL_NAME_PWD, fzfTerminalPwd);
        moveToPwd(term);
        term.sendText(makeSearchCmd(pattern), true);
    })));
    vscode.window.onDidCloseTerminal((terminal) => {
        switch (terminal.name) {
            case exports.TERMINAL_NAME:
                fzfTerminal = undefined;
                break;
            case exports.TERMINAL_NAME_PWD:
                fzfTerminalPwd = undefined;
                break;
        }
    });
}
exports.activate = activate;
function getSearchText() {
    var _a, _b, _c;
    return __awaiter(this, void 0, void 0, function* () {
        let activeSelection = (_a = vscode.window.activeTextEditor) === null || _a === void 0 ? void 0 : _a.selection;
        let value = undefined;
        if (activeSelection) {
            let activeRange;
            if (activeSelection.isEmpty) {
                activeRange = (_b = vscode.window.activeTextEditor) === null || _b === void 0 ? void 0 : _b.document.getWordRangeAtPosition(activeSelection.active);
            }
            else {
                activeRange = activeSelection;
            }
            value = activeRange ? (_c = vscode.window.activeTextEditor) === null || _c === void 0 ? void 0 : _c.document.getText(activeRange) : undefined;
        }
        // #33: Make default search more useful
        value = value || ".*";
        let pattern = yield vscode.window.showInputBox({
            prompt: "Search pattern",
            value: value
        });
        return pattern;
    });
}
function deactivate() {
    if (!isWindows() && fzfPipe) {
        fs.unlinkSync(fzfPipe);
        fzfPipe = undefined;
    }
}
exports.deactivate = deactivate;
/**
 * Return the command used to invoke rg. Exported to allow unit testing.
 * @param pattern Pattern to search for
 */
function makeSearchCmd(pattern) {
    let q = getQuote();
    return `rg ${q}${pattern}${q} ${rgFlags} --vimgrep --color ansi | ${getFzfCmd()} --ansi | ${getFzfPipeScript()} rg "${getFzfPipe()}"`;
}
exports.makeSearchCmd = makeSearchCmd;
//# sourceMappingURL=extension.js.map