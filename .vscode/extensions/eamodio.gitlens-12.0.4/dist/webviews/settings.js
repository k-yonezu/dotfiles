(()=>{"use strict";var Se={},G=Object.defineProperty,U=(i,t,e)=>t in i?G(i,t,{enumerable:!0,configurable:!0,writable:!0,value:e}):i[t]=e,X=(i,t,e)=>(U(i,typeof t!="symbol"?t+"":t,e),e);class V{constructor(t){this.method=t,X(this,"_")}}class k extends V{}class P extends V{}function _(i,t,e){i.method===t.method&&e(t.params)}const K=new k("webview/ready"),we=new k("command/execute"),Q=new k("configuration/preview"),ee=new k("configuration/update"),D=new P("configuration/didChange"),te=new P("configuration/didPreview"),E=new P("webview/didOpenAnchor"),L=/(?<literal>\[.*?\])|(?<year>YYYY|YY)|(?<month>M{1,4})|(?<day>Do|DD?)|(?<weekday>d{2,4})|(?<hour>HH?|hh?)|(?<minute>mm?)|(?<second>ss?)|(?<fractionalSecond>SSS)|(?<dayPeriod>A|a)|(?<timeZoneName>ZZ?)/g,B=/(?<dateStyle>full|long|medium|short)(?:\+(?<timeStyle>full|long|medium|short))?/,ne=null;let h;const C=new Map;let f,b,p;function oe(i){typeof i=="string"?i==="system"?f=void 0:f=[i]:f=i??void 0,b=void 0,p=void 0,C.clear(),h=void 0}function Pe(i,t){const e=new Date(i.getTime());for(const[n,o]of Object.entries(t))if(!!o)switch(n){case"years":e.setFullYear(e.getFullYear()+o);break;case"months":e.setMonth(e.getMonth()+o);break;case"days":e.setDate(e.getDate()+o);break;case"hours":e.setHours(e.getHours()+o);break;case"minutes":e.setMinutes(e.getMinutes()+o);break;case"seconds":e.setSeconds(e.getSeconds()+o);break}return e}function _e(i,t){const e=i.getTime()-new Date().getTime();for(const[n,o,s,r]of ne){const c=Math.abs(e);if(c>=o||o===1e3)return t?(h==null&&(p!=null?h=p.resolvedOptions().locale:b!=null?h=b.resolvedOptions().locale:(p=new Intl.RelativeTimeFormat(f,{localeMatcher:"best fit",numeric:"always",style:"narrow"}),h=p.resolvedOptions().locale)),h==="en"||h?.startsWith("en-")?`${Math.round(c/s)}${r}`:(p==null&&(p=new Intl.RelativeTimeFormat(f,{localeMatcher:"best fit",numeric:"always",style:"narrow"})),p.format(Math.round(e/s),n))):(b==null&&(b=new Intl.RelativeTimeFormat(f,{localeMatcher:"best fit",numeric:"auto",style:"long"})),b.format(Math.round(e/s),n))}return""}function N(i,t,e,n=!0){t=t??void 0;const o=`${e??""}:${t}`;let s=C.get(o);if(s==null){const c=se(t);let a;e==null?a=f:e==="system"?a=void 0:a=[e],s=new Intl.DateTimeFormat(a,c),n&&C.set(o,s)}if(t==null||B.test(t))return s.format(i);const r=s.formatToParts(i);return t.replace(L,(c,a,u,d,A,Te,$e,xe,Ie,Ae,Me,Ve,De,Ee,J)=>{if(a!=null)return a.substring(1,a.length-1);for(const Z in J){const M=J[Z];if(M==null)continue;const v=r.find(ke=>ke.type===Z);return M==="Do"&&v?.type==="day"?ie(Number(v.value)):M==="a"&&v?.type==="dayPeriod"?v.value.toLocaleLowerCase():v?.value??""}return""})}function Ce(i,t,e){const n=(typeof t=="number"?t:t.getTime())-(typeof i=="number"?i:i.getTime());switch(e){case"days":return Math.floor(n/(1e3*60*60*24));case"hours":return Math.floor(n/(1e3*60*60));case"minutes":return Math.floor(n/(1e3*60));case"seconds":return Math.floor(n/1e3);default:return n}}function se(i){if(i==null)return{localeMatcher:"best fit",dateStyle:"full",timeStyle:"short"};const t=B.exec(i);if(t?.groups!=null){const{dateStyle:n,timeStyle:o}=t.groups;return{localeMatcher:"best fit",dateStyle:n||"full",timeStyle:o||void 0}}const e={localeMatcher:"best fit"};for(const{groups:n}of i.matchAll(L))if(n!=null)for(const o in n){const s=n[o];if(s!=null)switch(o){case"year":e.year=s.length===4?"numeric":"2-digit";break;case"month":switch(s.length){case 4:e.month="long";break;case 3:e.month="short";break;case 2:e.month="2-digit";break;case 1:e.month="numeric";break}break;case"day":s==="DD"?e.day="2-digit":e.day="numeric";break;case"weekday":switch(s.length){case 4:e.weekday="long";break;case 3:e.weekday="short";break;case 2:e.weekday="narrow";break}break;case"hour":e.hour=s.length===2?"2-digit":"numeric",e.hour12=s==="hh"||s==="h";break;case"minute":e.minute=s.length===2?"2-digit":"numeric";break;case"second":e.second=s.length===2?"2-digit":"numeric";break;case"fractionalSecond":e.fractionalSecondDigits=3;break;case"dayPeriod":e.dayPeriod="narrow",e.hour12=!0;break;case"timeZoneName":e.timeZoneName=s.length===2?"long":"short";break}}return e}const T=["th","st","nd","rd"];function ie(i){const t=i%100;return`${i}${T[(t-20)%10]??T[t]??T[0]}`}var l;(i=>{function t(n,o,s,r){let c=!1;if(typeof n=="string"){const u=function(d){const A=d?.target;!A?.matches(n)||s(d,A)};return document.addEventListener(o,u,r??!0),{dispose:()=>{c||(c=!0,document.removeEventListener(o,u,r??!0))}}}const a=function(u){s(u,this)};return n.addEventListener(o,a,r??!1),{dispose:()=>{c||(c=!0,n.removeEventListener(o,a,r??!1))}}}i.on=t;function e(n,o,s){const r=document.getElementById(n)?.content.cloneNode(!0);if(o.replaceChildren(r),s?.visible!=null){const c=o.querySelectorAll("[data-visible]");for(const a of c){const u=a.dataset.visible;!u||(s.visible[u]?a.style.display="initial":a.style.display="none")}}if(s?.bindings!=null){const c=o.querySelectorAll("[data-bind]");for(const a of c){const u=a.dataset.bind;if(!u)continue;const d=s.bindings[u];d!=null&&(a.textContent=String(d))}}}i.insertTemplate=e})(l||(l={}));const re=/^(?:(#?)([0-9a-f]{3}|[0-9a-f]{6})|((?:rgb|hsl)a?)\((-?\d+%?)[,\s]+(-?\d+%?)[,\s]+(-?\d+%?)[,\s]*(-?[\d.]+%?)?\))$/i;function $(i,t){const e=i+t,n=t<0?e<0?0:e:e>255?255:e;return Math.round(n)}function g(i,t){return m(i,-t)}function m(i,t){const e=O(i);if(e==null)return i;const[n,o,s,r]=e,c=255*t/100;return`rgba(${$(n,c)}, ${$(o,c)}, ${$(s,c)}, ${r})`}function y(i,t){const e=O(i);if(e==null)return i;const[n,o,s,r]=e;return`rgba(${n}, ${o}, ${s}, ${r*(t/100)})`}function O(i){i=i.trim();const t=re.exec(i);if(t==null)return null;if(t[1]==="#"){const e=t[2];switch(e.length){case 3:return[parseInt(e[0]+e[0],16),parseInt(e[1]+e[1],16),parseInt(e[2]+e[2],16),1];case 6:return[parseInt(e.substring(0,2),16),parseInt(e.substring(2,4),16),parseInt(e.substring(4,6),16),1]}return null}switch(t[3]){case"rgb":return[parseInt(t[4],10),parseInt(t[5],10),parseInt(t[6],10),1];case"rgba":return[parseInt(t[4],10),parseInt(t[5],10),parseInt(t[6],10),parseFloat(t[7])];default:return null}}function ae(){const i=()=>{const e=document.body,n=window.getComputedStyle(e),o=e.style;o.setProperty("--font-family",n.getPropertyValue("--vscode-font-family").trim()),o.setProperty("--font-size",n.getPropertyValue("--vscode-font-size").trim()),o.setProperty("--font-weight",n.getPropertyValue("--vscode-font-weight").trim()),o.setProperty("--editor-font-family",n.getPropertyValue("--vscode-editor-font-family").trim()),o.setProperty("--editor-font-size",n.getPropertyValue("--vscode-editor-font-size").trim()),o.setProperty("--editor-font-weight",n.getPropertyValue("--vscode-editor-font-weight").trim());let s=n.getPropertyValue("--vscode-editor-background").trim();o.setProperty("--color-background",s),o.setProperty("--color-background--lighten-05",m(s,5)),o.setProperty("--color-background--darken-05",g(s,5)),o.setProperty("--color-background--lighten-075",m(s,7.5)),o.setProperty("--color-background--darken-075",g(s,7.5)),o.setProperty("--color-background--lighten-15",m(s,15)),o.setProperty("--color-background--darken-15",g(s,15)),o.setProperty("--color-background--lighten-30",m(s,30)),o.setProperty("--color-background--darken-30",g(s,30)),o.setProperty("--color-background--lighten-50",m(s,50)),o.setProperty("--color-background--darken-50",g(s,50)),s=n.getPropertyValue("--vscode-button-background").trim(),o.setProperty("--color-button-background",s),o.setProperty("--color-button-background--darken-30",g(s,30)),s=n.getPropertyValue("--vscode-button-secondaryBackground").trim(),o.setProperty("--color-button-secondary-background",s),o.setProperty("--color-button-secondary-background--darken-30",g(s,30)),s=n.getPropertyValue("--vscode-button-background").trim(),o.setProperty("--color-highlight",s),o.setProperty("--color-highlight--75",y(s,75)),o.setProperty("--color-highlight--50",y(s,50)),o.setProperty("--color-highlight--25",y(s,25)),s=n.getPropertyValue("--vscode-button-foreground").trim(),o.setProperty("--color-button-foreground",s);let r=n.getPropertyValue("--vscode-editor-foreground").trim();r||(r=n.getPropertyValue("--vscode-foreground").trim()),o.setProperty("--color-foreground",r),o.setProperty("--color-foreground--85",y(r,85)),o.setProperty("--color-foreground--75",y(r,75)),o.setProperty("--color-foreground--65",y(r,65)),o.setProperty("--color-foreground--50",y(r,50)),s=n.getPropertyValue("--vscode-focusBorder").trim(),o.setProperty("--color-focus-border",s),s=n.getPropertyValue("--vscode-textLink-foreground").trim(),o.setProperty("--color-link-foreground",s),o.setProperty("--color-link-foreground--darken-20",g(s,20)),o.setProperty("--color-link-foreground--lighten-20",m(s,20)),s=n.getPropertyValue("--vscode-sideBar-foreground").trim(),o.setProperty("--color-view-foreground",s||r),o.setProperty("--color-view-header-foreground",n.getPropertyValue("--vscode-sideBarSectionHeader-foreground").trim()||s||r),s=n.getPropertyValue("--vscode-editorHoverWidget-background").trim(),o.setProperty("--color-hover-background",s),s=n.getPropertyValue("--vscode-editorHoverWidget-border").trim(),o.setProperty("--color-hover-border",s),s=n.getPropertyValue("--vscode-editorHoverWidget-foreground").trim(),o.setProperty("--color-hover-foreground",s),s=n.getPropertyValue("--vscode-editorHoverWidget-statusBarBackground").trim(),o.setProperty("--color-hover-statusBarBackground",s)},t=new MutationObserver(i);return t.observe(document.body,{attributes:!0,attributeFilter:["class"]}),i(),t}var ce=Object.defineProperty,le=(i,t,e)=>t in i?ce(i,t,{enumerable:!0,configurable:!0,writable:!0,value:e}):i[t]=e,x=(i,t,e)=>(le(i,typeof t!="symbol"?t+"":t,e),e);let S=0;function q(){return S===Number.MAX_SAFE_INTEGER?S=1:S++,`webview:${S}`}class ue{constructor(t){this.appName=t,x(this,"_api"),x(this,"state"),x(this,"bindDisposables"),this.log(`${this.appName}.ctor`),this.state=window.bootstrap,window.bootstrap=void 0,this._api=acquireVsCodeApi(),ae(),requestAnimationFrame(()=>{this.log(`${this.appName}.initializing`);try{this.onInitialize?.(),this.bind(),this.onMessageReceived!=null&&window.addEventListener("message",this.onMessageReceived.bind(this)),this.sendCommand(K,void 0),this.onInitialized?.()}finally{setTimeout(()=>{document.body.classList.remove("preload")},500)}})}bind(){this.bindDisposables?.forEach(t=>t.dispose()),this.bindDisposables=this.onBind?.()}log(t){}getState(){return this._api.getState()}sendCommand(t,e){const n=q();return this.log(`${this.appName}.sendCommand(${n}): name=${t.method}`),this.postMessage({id:n,method:t.method,params:e})}sendCommandWithCompletion(t,e,n,o){const s=q();this.log(`${this.appName}.sendCommandWithCompletion(${s}): name=${t.method}`);const r=l.on(window,"message",c=>{_(n,c.data,a=>{a.completionId===s&&(r.dispose(),o(a))})});return this.postMessage({id:s,method:t.method,params:e})}setState(t){this.state=t,t!=null&&this._api.setState(t)}postMessage(t){this._api.postMessage(t)}}var de=Object.defineProperty,pe=(i,t,e)=>t in i?de(i,t,{enumerable:!0,configurable:!0,writable:!0,value:e}):i[t]=e,I=(i,t,e)=>(pe(i,typeof t!="symbol"?t+"":t,e),e);const F=new Date().getTimezoneOffset()/60*100,R=new Date(`Wed Jul 25 2018 19:18:00 GMT${F>=0?"-":"+"}${String(Math.abs(F)).padStart(4,"0")}`);class ge extends ue{constructor(t){super(t);I(this,"_changes",Object.create(null)),I(this,"_updating",!1),I(this,"_scrollTimer")}onInitialized(){this.updateState()}onBind(){const t=super.onBind?.()??[];return t.push(l.on("input[type=checkbox][data-setting]","change",(e,n)=>this.onInputChecked(n)),l.on("input[type=text][data-setting], input[type=number][data-setting], input:not([type])[data-setting]","blur",(e,n)=>this.onInputBlurred(n)),l.on("input[type=text][data-setting], input[type=number][data-setting], input:not([type])[data-setting]","focus",(e,n)=>this.onInputFocused(n)),l.on("input[type=text][data-setting][data-setting-preview], input[type=number][data-setting][data-setting-preview]","input",(e,n)=>this.onInputChanged(n)),l.on("select[data-setting]","change",(e,n)=>this.onInputSelected(n)),l.on(".popup","mousedown",(e,n)=>this.onPopupMouseDown(n,e))),t}onMessageReceived(t){const e=t.data;switch(this.log(`${this.appName}.onMessageReceived(${e.id}): name=${e.method}`),e.method){case E.method:{_(E,e,n=>{this.scrollToAnchor(n.anchor,n.scrollBehavior)});break}case D.method:_(D,e,n=>{this.state.config=n.config,this.state.customSettings=n.customSettings,this.updateState()});break;default:super.onMessageReceived?.(t)}}applyChanges(){this.sendCommand(ee,{changes:{...this._changes},removes:Object.keys(this._changes).filter(t=>this._changes[t]===void 0),scope:this.getSettingsScope()}),this._changes=Object.create(null)}getSettingsScope(){return"user"}onInputBlurred(t){this.log(`${this.appName}.onInputBlurred: name=${t.name}, value=${t.value}`);const e=document.getElementById(`${t.name}.popup`);e?.classList.add("hidden");let n=t.value;(n==null||n.length===0)&&(n=t.dataset.defaultValue,n===void 0&&(n=null)),this._changes[t.name]=t.type==="number"&&n!=null?Number(n):n,this.applyChanges()}onInputChanged(t){if(!this._updating)for(const e of document.querySelectorAll(`span[data-setting-preview="${t.name}"]`))this.updatePreview(e,t.value)}onInputChecked(t){if(!this._updating){switch(this.log(`${this.appName}.onInputChecked: name=${t.name}, checked=${t.checked}, value=${t.value}`),t.dataset.settingType){case"object":{const e=t.name.split("."),n=e.splice(0,1)[0],o=this.getSettingValue(n)??Object.create(null);t.checked?H(o,e.join("."),Y(t.value)):H(o,e.join("."),!1),this._changes[n]=o;break}case"array":{const e=this.getSettingValue(t.name)??[];if(Array.isArray(e)){if(t.checked)e.includes(t.value)||e.push(t.value);else{const n=e.indexOf(t.value);n!==-1&&e.splice(n,1)}this._changes[t.name]=e}break}case"custom":{this._changes[t.name]=t.checked;break}default:{t.checked?this._changes[t.name]=Y(t.value):this._changes[t.name]=t.dataset.valueOff==null?!1:t.dataset.valueOff;break}}this.setAdditionalSettings(t.checked?t.dataset.addSettingsOn:t.dataset.addSettingsOff),this.applyChanges()}}onInputFocused(t){this.log(`${this.appName}.onInputFocused: name=${t.name}, value=${t.value}`);const e=document.getElementById(`${t.name}.popup`);if(e!=null){if(e.childElementCount===0){const n=document.querySelector("#token-popup")?.content.cloneNode(!0);e.appendChild(n)}e.classList.remove("hidden")}}onInputSelected(t){if(this._updating)return;const e=t.options[t.selectedIndex].value;this.log(`${this.appName}.onInputSelected: name=${t.name}, value=${e}`),this._changes[t.name]=W(e),this.applyChanges()}onPopupMouseDown(t,e){e.preventDefault();const n=e.target;n?.matches("[data-token]")&&this.onTokenMouseDown(n,e)}onTokenMouseDown(t,e){if(this._updating)return;this.log(`${this.appName}.onTokenClicked: id=${t.id}`);const n=t.closest(".setting");if(n==null)return;const o=n.querySelector("input[type=text], input:not([type])");if(o==null)return;const s=`\${${t.dataset.token}}`;let r=o.selectionStart;r!=null?(o.value=`${o.value.substring(0,r)}${s}${o.value.substr(o.selectionEnd??r)}`,r+=s.length):r=o.value.length,o.focus(),o.setSelectionRange(r,r),r===o.value.length&&(o.scrollLeft=o.scrollWidth),setTimeout(()=>this.onInputChanged(o),0),setTimeout(()=>o.focus(),250),e.stopPropagation(),e.stopImmediatePropagation(),e.preventDefault()}scrollToAnchor(t,e,n){const o=document.getElementById(t);o!=null&&this.scrollTo(o,e,n)}scrollTo(t,e,n){const o=t.getBoundingClientRect().top-document.body.getBoundingClientRect().top-(n??0);window.scrollTo({top:o,behavior:e??"smooth"});const s=()=>{this._scrollTimer!=null&&clearTimeout(this._scrollTimer),this._scrollTimer=setTimeout(()=>{window.removeEventListener("scroll",s);const r=t.getBoundingClientRect().top-document.body.getBoundingClientRect().top-(n??0);o!==r&&this.scrollTo(t,e,n)},50)};window.addEventListener("scroll",s,!1)}evaluateStateExpression(t,e){let n=!1;for(const o of t.trim().split("&")){const[s,r,c]=me(o);switch(r){case"=":{let a=e[s];a===void 0&&(a=this.getSettingValue(s)??!1),n=c!==void 0?c===String(a):Boolean(a);break}case"!":{let a=e[s];a===void 0&&(a=this.getSettingValue(s)??!1),n=c!==void 0?c!==String(a):!a;break}case"+":{if(c!==void 0){const a=this.getSettingValue(s);n=a!==void 0?a.includes(c.toString()):!1}break}}if(!n)break}return n}getCustomSettingValue(t){return this.state.customSettings?.[t]}getSettingValue(t){const e=this.getCustomSettingValue(t);return e??he(this.state.config,t)}updateState(){this._updating=!0,oe(this.state.config.defaultDateLocale);try{for(const e of document.querySelectorAll("input[type=checkbox][data-setting]"))if(e.dataset.settingType==="custom")e.checked=this.getCustomSettingValue(e.name)??!1;else if(e.dataset.settingType==="array")e.checked=(this.getSettingValue(e.name)??[]).includes(e.value);else if(e.dataset.valueOff!=null){const n=this.getSettingValue(e.name);e.checked=e.dataset.valueOff!==n}else e.checked=this.getSettingValue(e.name)??!1;for(const e of document.querySelectorAll("input[type=text][data-setting], input[type=number][data-setting], input:not([type])[data-setting]"))e.value=this.getSettingValue(e.name)??"";for(const e of document.querySelectorAll("select[data-setting]")){const n=this.getSettingValue(e.name),o=e.querySelector(`option[value='${n}']`);o!=null&&(o.selected=!0)}for(const e of document.querySelectorAll("span[data-setting-preview]"))this.updatePreview(e)}finally{this._updating=!1}const t=j(this.state.config);this.setVisibility(t),this.setEnablement(t)}setAdditionalSettings(t){if(!t)return;const e=fe(t);for(const[n,o]of e)this._changes[n]=o}setEnablement(t){for(const e of document.querySelectorAll("[data-enablement]")){const n=!this.evaluateStateExpression(e.dataset.enablement,t);if(n?e.setAttribute("disabled",""):e.removeAttribute("disabled"),e.matches("input,select"))e.disabled=n;else{const o=e.querySelector("input,select");if(o==null)continue;o.disabled=n}}}setVisibility(t){for(const e of document.querySelectorAll("[data-visibility]"))e.classList.toggle("hidden",!this.evaluateStateExpression(e.dataset.visibility,t))}updatePreview(t,e){switch(t.dataset.settingPreviewType){case"date":{e===void 0&&(e=this.getSettingValue(t.dataset.settingPreview)),e||(e=t.dataset.settingPreviewDefault),t.innerText=e==null?"":N(R,e,void 0,!1);break}case"date-locale":{e===void 0&&(e=this.getSettingValue(t.dataset.settingPreview)),e||(e=void 0);const n=this.getSettingValue(t.dataset.settingPreviewDefault)??"MMMM Do, YYYY h:mma";try{t.innerText=N(R,n,e,!1)}catch(o){t.innerText=o.message}break}case"commit":{if(e===void 0&&(e=this.getSettingValue(t.dataset.settingPreview)),e||(e=t.dataset.settingPreviewDefault),e==null){t.innerText="";return}this.sendCommandWithCompletion(Q,{key:t.dataset.settingPreview,type:"commit",format:e},te,n=>{t.innerText=n.preview??""});break}default:break}}}function W(i){return i==="true"?!0:i==="false"?!1:i==="null"?null:i}function he(i,t){return t.split(".").reduce((e={},n)=>e?.[n],i)}function H(i,t,e){const n=t.split("."),o=n.length,s=o-1;let r=-1,c=i;for(;c!=null&&++r<o;){const a=n[r];let u=e;if(r!==s){const d=c[a];u=typeof d=="object"?d:{}}c[a]=u,c=c[a]}return i}function fe(i){return i.trim().split(",").map(e=>{const[n,o]=e.split("=");return[n,W(o)]})}function me(i){const[t,e,n]=i.trim().split(/([=+!])/);return[t.trim(),e!==void 0?e.trim():"=",n!==void 0?n.trim():n]}function j(i,t){const e={};for(const n in i){const o=i[n];Array.isArray(o)||(typeof o=="object"?Object.assign(e,j(o,t===void 0?n:`${t}.${n}`)):e[t===void 0?n:`${t}.${n}`]=o)}return e}function Y(i){switch(i){case"on":return!0;case"null":return null;case"undefined":return;default:return i}}var ye=Object.defineProperty,be=(i,t,e)=>t in i?ye(i,t,{enumerable:!0,configurable:!0,writable:!0,value:e}):i[t]=e,w=(i,t,e)=>(be(i,typeof t!="symbol"?t+"":t,e),e);const z=83;class ve extends ge{constructor(){super("SettingsApp");w(this,"_scopes",null),w(this,"_observer"),w(this,"_activeSection","general"),w(this,"_sections",new Map)}onInitialize(){const t=document.getElementById("scopes");if(t!=null&&this.state.scopes.length>1){for(const[o,s]of this.state.scopes){const r=document.createElement("option");r.value=o,r.innerHTML=s,this.state.scope===o&&(r.selected=!0),t.appendChild(r)}t.parentElement.parentElement.classList.remove("hidden"),this._scopes=t}let e=z;const n=document.querySelector(".hero__area--sticky");n!=null&&(e=n.clientHeight),this._observer=new IntersectionObserver(this.onObserver.bind(this),{rootMargin:`-${e}px 0px 0px 0px`});for(const o of document.querySelectorAll("section[id]>.section__header"))this._sections.set(o.parentElement.id,!1),this._observer.observe(o);for(const o of document.querySelectorAll("[data-setting]")){!o.title&&o.type==="checkbox"&&(o.title=`Setting name: "gitlens.${o.name}"`);for(const s of document.querySelectorAll(`label[for="${o.id}"]`))s.title||(s.title=`Setting name: "gitlens.${o.name}"`)}}onBind(){const t=super.onBind?.()??[];return t.push(l.on(".section--collapsible>.section__header","click",(e,n)=>this.onSectionHeaderClicked(n,e)),l.on(".setting--expandable .setting__expander","click",(e,n)=>this.onSettingExpanderCicked(n,e)),l.on('a[data-action="jump"]',"mousedown",e=>{e.stopPropagation(),e.preventDefault()}),l.on('a[data-action="jump"]',"click",(e,n)=>this.onJumpToLinkClicked(n,e)),l.on("[data-action]","mousedown",e=>{e.stopPropagation(),e.preventDefault()}),l.on("[data-action]","click",(e,n)=>this.onActionLinkClicked(n,e))),t}scrollToAnchor(t,e){let n=z;const o=document.querySelector(".hero__area--sticky");o!=null&&(n=o.clientHeight),super.scrollToAnchor(t,e,n)}onObserver(t,e){for(const o of t)this._sections.set(o.target.parentElement.id,o.isIntersecting);let n;for(const[o,s]of this._sections.entries())if(s){n=o;break}if(n===void 0){if(t.length!==1)return;const o=t[0];if(o.boundingClientRect==null||o.rootBounds==null)return;if(n=o.target.parentElement.id,o.boundingClientRect.top>=o.rootBounds.bottom){const s=[...this._sections.keys()],r=s.indexOf(n);if(r<=0)return;n=s[r-1]}}this._activeSection!==n&&(this._activeSection!==void 0&&this.toggleJumpLink(this._activeSection,!1),this._activeSection=n,this.toggleJumpLink(this._activeSection,!0))}getSettingsScope(){return this._scopes!=null?this._scopes.options[this._scopes.selectedIndex].value:"user"}onActionLinkClicked(t,e){switch(t.dataset.action){case"collapse":for(const n of document.querySelectorAll(".section--collapsible"))n.classList.add("collapsed");document.querySelector('[data-action="collapse"]').classList.add("hidden"),document.querySelector('[data-action="expand"]').classList.remove("hidden");break;case"expand":for(const n of document.querySelectorAll(".section--collapsible"))n.classList.remove("collapsed");document.querySelector('[data-action="collapse"]').classList.remove("hidden"),document.querySelector('[data-action="expand"]').classList.add("hidden");break}e.preventDefault(),e.stopPropagation()}onInputSelected(t){t!==this._scopes&&super.onInputSelected(t)}onJumpToLinkClicked(t,e){const n=t.getAttribute("href");if(n==null)return;const o=n.substr(1);this.scrollToAnchor(o,"smooth"),e.stopPropagation(),e.preventDefault()}onSectionHeaderClicked(t,e){e.target.matches("a, input, label, i.icon__info")||t.parentElement.classList.toggle("collapsed")}onSettingExpanderCicked(t,e){t.parentElement.parentElement.classList.toggle("expanded")}toggleJumpLink(t,e){const n=document.querySelector(`a.sidebar__jump-link[href="#${t}"]`);n?.classList.toggle("active",e)}}new ve})();

//# sourceMappingURL=settings.js.map