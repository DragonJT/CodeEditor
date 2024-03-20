using System;
using System.Collections;
using SDL2;
namespace CodeEditor;

class TextEditor
{
	String text = new String();
	String colors = new String();
	int cursor = 0;
	float x,y;
	String buffer = new String();
	float cursorX,cursorY;
	List<SDL.Color> colorMap = new List<SDL.Color>();

	void InsertTextIntoString(String str, String value){
		buffer.Clear();
		str.Substring(0, cursor).ToString(buffer);
		buffer.Append(value);
		str.Substring(cursor).ToString(buffer);
		str.Clear();
		str.Append(buffer);
	}

	void BackspaceText(String str){
		buffer.Clear();
		str.Substring(0, cursor-1).ToString(buffer);
		str.Substring(cursor).ToString(buffer);
		str.Clear();
		str.Append(buffer);
	}

	char8 GetColor(int index){
		if(index<0 || index>=colors.Length){
			return 0;
		}
		return colors[index];
	}

	public void InsertText(String value){
		InsertTextIntoString(text, value);
		var colorBuffer = scope String(GetColor(cursor-1), value.Length);
		InsertTextIntoString(colors, colorBuffer);
		cursor+=value.Length;
	}

	public void Backspace(){
		if(cursor>0){
			BackspaceText(text);
			BackspaceText(colors);
			cursor--;
		}
	}

	public void MoveCursorLeft(){
		if(cursor>0){
			cursor--;
		}
	}

	public void MoveCursorRight(){
		if(cursor<text.Length){
			cursor++;
		}
	}

	public this(){
		colorMap.Add(SDL.Color(0,200,255,255));
		colorMap.Add(SDL.Color(255,200,0,255));
	}

	public ~this(){
		delete text;
		delete buffer;
		delete colorMap;
		delete colors;
	}

	public void Draw(){
		x = gameApp.lineSize;
		y = gameApp.lineSize;
		var bufferLen1 = scope String(1);

		for(var i=0;i<text.Length;i++){
			if(i>10){
				colors[i] = (char8)1;
			}
			if(cursor == i){
				cursorX = x;
				cursorY = y;
			}
			if(text[i] == '\n'){
				x = gameApp.lineSize;
				y+= gameApp.lineSize;
			}
			else if(text[i] == ' '){
				x += gameApp.spaceLength;
			}
			else if(text[i] == '\t'){
				x += gameApp.spaceLength * 4;
			}
			else{
				bufferLen1.Clear();
				text[i].ToString(bufferLen1);
				gameApp.DrawString(gameApp.font, x, y, bufferLen1, colorMap[(int)colors[i]]);
				int w,h;
				SDLTTF.SizeText(gameApp.font.mFont, bufferLen1, out w, out h);
				x += w;
			}
		}
		if(cursor == text.Length){
			cursorX = x;
			cursorY = y;
		}
		SDL.SetRenderDrawColor(gameApp.mRenderer, 0, 200, 255, 255);
		SDL.RenderFillRect(gameApp.mRenderer,  &SDL.Rect((int32)cursorX, (int32)cursorY, 2, (int32)gameApp.fontSize));
	}
}