using System;
using System.Collections;
using SDL2;
namespace CodeEditor;


class TextEditor
{
	String text = new String();
	int cursor = 0;
	float x,y;
	String buffer = new String();
	float cursorX,cursorY;

	public void InsertText(String value){
		buffer.Clear();
		text.Substring(0, cursor).ToString(buffer);
		buffer.Append(value);
		text.Substring(cursor).ToString(buffer);
		text.Clear();
		text.Append(buffer);
		cursor+=value.Length;
	}

	public void Backspace(){
		if(cursor>0){
			buffer.Clear();
			text.Substring(0, cursor-1).ToString(buffer);
			text.Substring(cursor).ToString(buffer);
			text.Clear();
			text.Append(buffer);
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
	}

	public ~this(){
		delete text;
		delete buffer;
	}

	public void Draw(){
		x = gameApp.lineSize;
		y = gameApp.lineSize;
		var bufferLen1 = scope String(1);

		for(var i=0;i<text.Length;i++){
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
				gameApp.DrawString(gameApp.font, x, y, bufferLen1, SDL.Color(0,100,255,255));
				int w,h;
				SDLTTF.SizeText(gameApp.font.mFont, bufferLen1, out w, out h);
				x += w;
			}
		}
		if(cursor == text.Length){
			cursorX = x;
			cursorY = y;
		}
		SDL.SetRenderDrawColor(gameApp.mRenderer, 0, 100, 255, 255);
		SDL.RenderFillRect(gameApp.mRenderer,  &SDL.Rect((int32)cursorX, (int32)cursorY, 2, (int32)gameApp.fontSize));
	}
}