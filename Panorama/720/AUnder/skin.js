// Garden Gnome Software - Skin
// Pano2VR 5.2.5/15998
// Filename: anman.ggsk
// Generated 周五 一月 10 14:07:46 2020

function pano2vrSkin(player,base) {
	var ggSkinVars = [];
	ggSkinVars['ht_ani'] = false;
	var me=this;
	var flag=false;
	this.player=player;
	this.player.skinObj=this;
	this.divSkin=player.divSkin;
	this.ggUserdata=me.player.userdata;
	this.lastSize={ w: -1,h: -1 };
	var basePath="AUnder/";
	// auto detect base path
	if (base=='?') {
		var scripts = document.getElementsByTagName('script');
		for(var i=0;i<scripts.length;i++) {
			var src=scripts[i].src;
			if (src.indexOf('skin.js')>=0) {
				var p=src.lastIndexOf('/');
				if (p>=0) {
					basePath=src.substr(0,p+1);
				}
			}
		}
	} else
	if (base) {
		basePath=base;
	}
	this.elementMouseDown=[];
	this.elementMouseOver=[];
	var cssPrefix='';
	var domTransition='transition';
	var domTransform='transform';
	var prefixes='Webkit,Moz,O,ms,Ms'.split(',');
	var i;
	if (typeof document.body.style['transform'] == 'undefined') {
		for(var i=0;i<prefixes.length;i++) {
			if (typeof document.body.style[prefixes[i] + 'Transform'] !== 'undefined') {
				cssPrefix='-' + prefixes[i].toLowerCase() + '-';
				domTransition=prefixes[i] + 'Transition';
				domTransform=prefixes[i] + 'Transform';
			}
		}
	}
	
	this.player.setMargins(0,0,0,0);
	
	this.updateSize=function(startElement) {
		var stack=[];
		stack.push(startElement);
		while(stack.length>0) {
			var e=stack.pop();
			if (e.ggUpdatePosition) {
				e.ggUpdatePosition();
			}
			if (e.hasChildNodes()) {
				for(var i=0;i<e.childNodes.length;i++) {
					stack.push(e.childNodes[i]);
				}
			}
		}
	}
	
	parameterToTransform=function(p) {
		var hs='translate(' + p.rx + 'px,' + p.ry + 'px) rotate(' + p.a + 'deg) scale(' + p.sx + ',' + p.sy + ')';
		return hs;
	}
	
	this.findElements=function(id,regex) {
		var r=[];
		var stack=[];
		var pat=new RegExp(id,'');
		stack.push(me.divSkin);
		while(stack.length>0) {
			var e=stack.pop();
			if (regex) {
				if (pat.test(e.ggId)) r.push(e);
			} else {
				if (e.ggId==id) r.push(e);
			}
			if (e.hasChildNodes()) {
				for(var i=0;i<e.childNodes.length;i++) {
					stack.push(e.childNodes[i]);
				}
			}
		}
		return r;
	}
	
	this.addSkin=function() {
		var hs='';
		this.ggCurrentTime=new Date().getTime();
		this._timer_1=document.createElement('div');
		this._timer_1.ggTimestamp=this.ggCurrentTime;
		this._timer_1.ggLastIsActive=true;
		this._timer_1.ggTimeout=1000;
		this._timer_1.ggId="Timer 1";
		this._timer_1.ggParameter={ rx:0,ry:0,a:0,sx:1,sy:1 };
		this._timer_1.ggVisible=true;
		this._timer_1.className='ggskin ggskin_timer ';
		this._timer_1.ggType='timer';
		hs ='';
		hs+='height : 22px;';
		hs+='left : 8px;';
		hs+='position : absolute;';
		hs+='top : 8px;';
		hs+='visibility : inherit;';
		hs+='width : 93px;';
		hs+='pointer-events:none;';
		this._timer_1.setAttribute('style',hs);
		this._timer_1.style[domTransform + 'Origin']='50% 50%';
		me._timer_1.ggIsActive=function() {
			return (me._timer_1.ggTimestamp==0 ? false : (Math.floor((me.ggCurrentTime - me._timer_1.ggTimestamp) / me._timer_1.ggTimeout) % 2 == 0));
		}
		me._timer_1.ggElementNodeId=function() {
			return me.player.getCurrentNode();
		}
		this._timer_1.ggActivate=function () {
			ggSkinVars['ht_ani'] = true;
		}
		this._timer_1.ggDeactivate=function () {
			ggSkinVars['ht_ani'] = false;
		}
		this._timer_1.ggUpdatePosition=function (useTransition) {
		}
		this.divSkin.appendChild(this._timer_1);
		this.divSkin.ggUpdateSize=function(w,h) {
			me.updateSize(me.divSkin);
		}
		this.divSkin.ggViewerInit=function() {
		}
		this.divSkin.ggLoaded=function() {
		}
		this.divSkin.ggReLoaded=function() {
		}
		this.divSkin.ggLoadedLevels=function() {
		}
		this.divSkin.ggReLoadedLevels=function() {
		}
		this.divSkin.ggEnterFullscreen=function() {
		}
		this.divSkin.ggExitFullscreen=function() {
		}
		this.skinTimerEvent();
	};
	this.hotspotProxyClick=function(id) {
	}
	this.hotspotProxyOver=function(id) {
	}
	this.hotspotProxyOut=function(id) {
	}
	this.ggHotspotCallChildFunctions=function(functionname) {
		var stack = me.player.getCurrentPointHotspots();
		while (stack.length > 0) {
			var e = stack.pop();
			if (typeof e[functionname] == 'function') {
				e[functionname]();
			}
			if(e.hasChildNodes()) {
				for(var i=0; i<e.childNodes.length; i++) {
					stack.push(e.childNodes[i]);
				}
			}
		}
	}
	this.changeActiveNode=function(id) {
		me.ggUserdata=me.player.userdata;
	}
	this.skinTimerEvent=function() {
		setTimeout(function() { me.skinTimerEvent(); }, 10);
		me.ggCurrentTime=new Date().getTime();
		if (me._timer_1.ggLastIsActive!=me._timer_1.ggIsActive()) {
			me._timer_1.ggLastIsActive=me._timer_1.ggIsActive();
			if (me._timer_1.ggLastIsActive) {
				ggSkinVars['ht_ani'] = true;
			} else {
				ggSkinVars['ht_ani'] = false;
			}
		}
		me.ggHotspotCallChildFunctions('ggUpdateConditionTimer');
	};
	function SkinHotspotClass(skinObj,hotspot) {
		var me=this;
		var flag=false;
		this.player=skinObj.player;
		this.skin=skinObj;
		this.hotspot=hotspot;
		var nodeId=String(hotspot.url);
		nodeId=(nodeId.charAt(0)=='{')?nodeId.substr(1, nodeId.length - 2):'';
		this.ggUserdata=this.skin.player.getNodeUserdata(nodeId);
		this.elementMouseDown=[];
		this.elementMouseOver=[];
		
		this.findElements=function(id,regex) {
			return me.skin.findElements(id,regex);
		}
		
		{
			this.__div=document.createElement('div');
			this.__div.ggId="Hotspot 1";
			this.__div.ggParameter={ rx:0,ry:0,a:0,sx:1,sy:1 };
			this.__div.ggVisible=true;
			this.__div.className='ggskin ggskin_hotspot up1';
			this.__div.ggType='hotspot';
			hs ='';
			hs+='height : 5px;';
			hs+='left : 130px;';
			hs+='position : absolute;';
			hs+='top : 135px;';
			hs+='visibility : inherit;';
			hs+='width : 5px;';
			hs+='pointer-events:auto;';
			hs+='.up1{border:20px,solid,#f00;background-color: #f2f8ff;}';
			this.__div.setAttribute('style',hs);
			this.__div.style[domTransform + 'Origin']='50% 50%';
			me.__div.ggIsActive=function() {
				return me.player.getCurrentNode()==this.ggElementNodeId();
			}
			me.__div.ggElementNodeId=function() {
				return me.hotspot.url.substr(1, me.hotspot.url.length - 2);
			}
			this.__div.onclick=function (e) {
                window.skin = me;
                window.webkit.messageHandlers.jsToOcWithPrams.postMessage({"params":me.hotspot.url});
				me.player.openNext(me.hotspot.url,me.hotspot.target);
				me.skin.hotspotProxyClick(me.hotspot.id);
			}
			this.__div.onmouseover=function (e) {
				me.player.setActiveHotspot(me.hotspot);
				me.skin.hotspotProxyOver(me.hotspot.id);
			}
			this.__div.onmouseout=function (e) {
				me.player.setActiveHotspot(null);
				me.skin.hotspotProxyOut(me.hotspot.id);
			}
			this.__div.ggUpdatePosition=function (useTransition) {
			}
			this._ht_image=document.createElement('div');
			this._ht_image.ggId="ht_image";
			this._ht_image.ggLeft=-18;
			this._ht_image.ggTop=-17;
			this._ht_image.ggParameter={ rx:0,ry:0,a:0,sx:1,sy:1 };
			this._ht_image.ggVisible=true;
			this._ht_image.className='ggskin ggskin_container ';
			this._ht_image.ggType='container';
			hs ='';
			hs+='height : 32px;';
			hs+='left : -18px;';
			hs+='position : absolute;';
			hs+='top : -17px;';
			hs+='visibility : inherit;';
			hs+='width : 32px;';
			hs+='pointer-events:none;';
			this._ht_image.setAttribute('style',hs);
			this._ht_image.style[domTransform + 'Origin']='50% 50%';
			me._ht_image.ggIsActive=function() {
				if ((this.parentNode) && (this.parentNode.ggIsActive)) {
					return this.parentNode.ggIsActive();
				}
				return false;
			}
			me._ht_image.ggElementNodeId=function() {
				if ((this.parentNode) && (this.parentNode.ggElementNodeId)) {
					return this.parentNode.ggElementNodeId();
				}
				return me.ggNodeId;
			}
			this._ht_image.ggUpdatePosition=function (useTransition) {
				if (useTransition==='undefined') {
					useTransition = false;
				}
				if (!useTransition) {
					this.style[domTransition]='none';
				}
				if (this.parentNode) {
					var w=this.parentNode.offsetWidth;
						this.style.left=(this.ggLeft - 0 + w/2) + 'px';
					var h=this.parentNode.offsetHeight;
						this.style.top=(this.ggTop - 0 + h/2) + 'px';
				}
			}
			this._rectangle_1=document.createElement('div');
			this._rectangle_1.ggId="Rectangle 1";
			this._rectangle_1.ggLeft=-16;
			this._rectangle_1.ggTop=-16;
			this._rectangle_1.ggParameter={ rx:0,ry:0,a:0,sx:0.5,sy:0.5 };
			this._rectangle_1.ggVisible=true;
			this._rectangle_1.className='ggskin ggskin_rectangle ';
			this._rectangle_1.ggType='rectangle';
			hs ='';
			hs+=cssPrefix + 'border-radius : 20px;';
			hs+='border-radius : 20px;';
			hs+='border : 2px solid #ffffff;';
			hs+='cursor : default;';
			hs+='height : 30px;';
			hs+='left : -17px;';
			hs+='position : absolute;';
			hs+='top : -17px;';
			hs+='visibility : inherit;';
			hs+='width : 30px;';
			hs+='pointer-events:auto;';
			this._rectangle_1.setAttribute('style',hs);
			this._rectangle_1.style[domTransform + 'Origin']='50% 50%';
			this._rectangle_1.style[domTransform]=parameterToTransform(this._rectangle_1.ggParameter);
			me._rectangle_1.ggIsActive=function() {
				if ((this.parentNode) && (this.parentNode.ggIsActive)) {
					return this.parentNode.ggIsActive();
				}
				return false;
			}
			me._rectangle_1.ggElementNodeId=function() {
				if ((this.parentNode) && (this.parentNode.ggElementNodeId)) {
					return this.parentNode.ggElementNodeId();
				}
				return me.ggNodeId;
			}
			me._rectangle_1.ggCurrentLogicStateScaling = -1;
			me._rectangle_1.ggCurrentLogicStateAlpha = -1;
			this._rectangle_1.ggUpdateConditionTimer=function () {
				var newLogicStateScaling;
				if (
					(ggSkinVars['ht_ani'] == true)
				)
				{
					newLogicStateScaling = 0;
				}
				else {
					newLogicStateScaling = -1;
				}
				if (me._rectangle_1.ggCurrentLogicStateScaling != newLogicStateScaling) {
					me._rectangle_1.ggCurrentLogicStateScaling = newLogicStateScaling;
					me._rectangle_1.style[domTransition]='' + cssPrefix + 'transform 500ms ease 0ms, opacity 500ms ease 0ms, visibility 500ms ease 0ms';
					if (me._rectangle_1.ggCurrentLogicStateScaling == 0) {
						me._rectangle_1.ggParameter.sx = 1;
						me._rectangle_1.ggParameter.sy = 1;
						me._rectangle_1.style[domTransform]=parameterToTransform(me._rectangle_1.ggParameter);
					}
					else {
						me._rectangle_1.ggParameter.sx = 0.5;
						me._rectangle_1.ggParameter.sy = 0.5;
						me._rectangle_1.style[domTransform]=parameterToTransform(me._rectangle_1.ggParameter);
					}
				}
				var newLogicStateAlpha;
				if (
					(ggSkinVars['ht_ani'] == true)
				)
				{
					newLogicStateAlpha = 0;
				}
				else {
					newLogicStateAlpha = -1;
				}
				if (me._rectangle_1.ggCurrentLogicStateAlpha != newLogicStateAlpha) {
					me._rectangle_1.ggCurrentLogicStateAlpha = newLogicStateAlpha;
					me._rectangle_1.style[domTransition]='' + cssPrefix + 'transform 500ms ease 0ms, opacity 500ms ease 0ms, visibility 500ms ease 0ms';
					if (me._rectangle_1.ggCurrentLogicStateAlpha == 0) {
						me._rectangle_1.style.visibility="hidden";
						me._rectangle_1.style.opacity=0;
					}
					else {
						me._rectangle_1.style.visibility=me._rectangle_1.ggVisible?'inherit':'hidden';
						me._rectangle_1.style.opacity=1;
					}
				}
			}
			this._rectangle_1.ggUpdatePosition=function (useTransition) {
				if (useTransition==='undefined') {
					useTransition = false;
				}
				if (!useTransition) {
					this.style[domTransition]='none';
				}
				if (this.parentNode) {
					var w=this.parentNode.offsetWidth;
						this.style.left=(this.ggLeft - 0 + w/2) + 'px';
					var h=this.parentNode.offsetHeight;
						this.style.top=(this.ggTop - 0 + h/2) + 'px';
				}
			}
			this._ht_image.appendChild(this._rectangle_1);
			this._rectangle_2=document.createElement('div');
			this._rectangle_2.ggId="Rectangle 2";
			this._rectangle_2.ggLeft=-16;
			this._rectangle_2.ggTop=-16;
			this._rectangle_2.ggParameter={ rx:0,ry:0,a:0,sx:1,sy:1 };
			this._rectangle_2.ggVisible=true;
			this._rectangle_2.className='ggskin ggskin_rectangle ';
			this._rectangle_2.ggType='rectangle';
			hs ='';
			hs+=cssPrefix + 'border-radius : 20px;';
			hs+='border-radius : 20px;';
			hs+='border : 2px solid #ffffff;';
			hs+='cursor : default;';
			hs+='height : 30px;';
			hs+='left : -17px;';
			hs+='opacity : 0;';
			hs+='position : absolute;';
			hs+='top : -17px;';
			hs+='visibility : hidden;';
			hs+='width : 30px;';
			hs+='pointer-events:auto;';
			this._rectangle_2.setAttribute('style',hs);
			this._rectangle_2.style[domTransform + 'Origin']='50% 50%';
			me._rectangle_2.ggIsActive=function() {
				if ((this.parentNode) && (this.parentNode.ggIsActive)) {
					return this.parentNode.ggIsActive();
				}
				return false;
			}
			me._rectangle_2.ggElementNodeId=function() {
				if ((this.parentNode) && (this.parentNode.ggElementNodeId)) {
					return this.parentNode.ggElementNodeId();
				}
				return me.ggNodeId;
			}
			me._rectangle_2.ggCurrentLogicStateScaling = -1;
			me._rectangle_2.ggCurrentLogicStateAlpha = -1;
			this._rectangle_2.ggUpdateConditionTimer=function () {
				var newLogicStateScaling;
				if (
					(ggSkinVars['ht_ani'] == true)
				)
				{
					newLogicStateScaling = 0;
				}
				else {
					newLogicStateScaling = -1;
				}
				if (me._rectangle_2.ggCurrentLogicStateScaling != newLogicStateScaling) {
					me._rectangle_2.ggCurrentLogicStateScaling = newLogicStateScaling;
					me._rectangle_2.style[domTransition]='' + cssPrefix + 'transform 500ms ease 0ms, opacity 500ms ease 0ms, visibility 500ms ease 0ms';
					if (me._rectangle_2.ggCurrentLogicStateScaling == 0) {
						me._rectangle_2.ggParameter.sx = 0.5;
						me._rectangle_2.ggParameter.sy = 0.5;
						me._rectangle_2.style[domTransform]=parameterToTransform(me._rectangle_2.ggParameter);
					}
					else {
						me._rectangle_2.ggParameter.sx = 1;
						me._rectangle_2.ggParameter.sy = 1;
						me._rectangle_2.style[domTransform]=parameterToTransform(me._rectangle_2.ggParameter);
					}
				}
				var newLogicStateAlpha;
				if (
					(ggSkinVars['ht_ani'] == true)
				)
				{
					newLogicStateAlpha = 0;
				}
				else {
					newLogicStateAlpha = -1;
				}
				if (me._rectangle_2.ggCurrentLogicStateAlpha != newLogicStateAlpha) {
					me._rectangle_2.ggCurrentLogicStateAlpha = newLogicStateAlpha;
					me._rectangle_2.style[domTransition]='' + cssPrefix + 'transform 500ms ease 0ms, opacity 500ms ease 0ms, visibility 500ms ease 0ms';
					if (me._rectangle_2.ggCurrentLogicStateAlpha == 0) {
						me._rectangle_2.style.visibility=me._rectangle_2.ggVisible?'inherit':'hidden';
						me._rectangle_2.style.opacity=1;
					}
					else {
						me._rectangle_2.style.visibility="hidden";
						me._rectangle_2.style.opacity=0;
					}
				}
			}
			this._rectangle_2.ggUpdatePosition=function (useTransition) {
				if (useTransition==='undefined') {
					useTransition = false;
				}
				if (!useTransition) {
					this.style[domTransition]='none';
				}
				if (this.parentNode) {
					var w=this.parentNode.offsetWidth;
						this.style.left=(this.ggLeft - 0 + w/2) + 'px';
					var h=this.parentNode.offsetHeight;
						this.style.top=(this.ggTop - 0 + h/2) + 'px';
				}
			}
			this._ht_image.appendChild(this._rectangle_2);
			this.__div.appendChild(this._ht_image);
			this._text_1=document.createElement('div');
			this._text_1__text=document.createElement('div');
			this._text_1.className='ggskin ggskin_textdiv';
			this._text_1.ggTextDiv=this._text_1__text;
			this._text_1.ggId="Text 1";
			this._text_1.ggParameter={ rx:0,ry:0,a:0,sx:1,sy:1 };
			this._text_1.ggVisible=true;
			this._text_1.className='ggskin ggskin_text ';
			this._text_1.ggType='text';
			hs ='';
			hs+='height : 20px;';
			hs+='left : -99px;';
			hs+='position : absolute;';
			hs+='top : -41px;';
			hs+='visibility : inherit;';
			hs+='width : 196px;';
			hs+='pointer-events:auto;';
			this._text_1.setAttribute('style',hs);
			this._text_1.style[domTransform + 'Origin']='50% 50%';
			hs ='position:absolute;';
			hs+='cursor: default;';
			hs+='left: 0px;';
			hs+='top:  0px;';
			hs+='width: auto;';
			hs+='height: auto;';
			hs+='background: #7d7d7d;';
			hs+='background: rgba(125,125,125,0.490196);';
			hs+='border: 0px solid #000000;';
			hs+='border-radius: 6px;';
			hs+=cssPrefix + 'border-radius: 6px;';
			hs+='color: rgba(255,255,255,0.784314);';
			hs+='text-align: center;';
			hs+='white-space: nowrap;';
			hs+='padding: 5px 12px 5px 12px;';
			hs+='overflow: hidden;';
			this._text_1__text.setAttribute('style',hs);
			this._text_1__text.innerHTML=me.hotspot.title;
			this._text_1.appendChild(this._text_1__text);
			me._text_1.ggIsActive=function() {
				if ((this.parentNode) && (this.parentNode.ggIsActive)) {
					return this.parentNode.ggIsActive();
				}
				return false;
			}
			me._text_1.ggElementNodeId=function() {
				if ((this.parentNode) && (this.parentNode.ggElementNodeId)) {
					return this.parentNode.ggElementNodeId();
				}
				return me.ggNodeId;
			}
			this._text_1.ggUpdatePosition=function (useTransition) {
				this.style[domTransition]='none';
				this.ggTextDiv.style.left=((198-this.ggTextDiv.offsetWidth)/2) + 'px';
			}
			this.__div.appendChild(this._text_1);
			this.hotspotTimerEvent=function() {
				setTimeout(function() { me.hotspotTimerEvent(); }, 10);
				me._rectangle_1.ggUpdateConditionTimer();
				me._rectangle_2.ggUpdateConditionTimer();
			}
			this.hotspotTimerEvent();
		}
	};
	this.addSkinHotspot=function(hotspot) {
		return new SkinHotspotClass(me,hotspot);
	}
	this.addSkin();
};
