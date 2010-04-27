//
//  ShoootSurfaceView.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ShoootSurfaceView.h"


@implementation ShoootSurfaceView

@end

/* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

import android.content.Context;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.MotionEvent;

public class ShoootSurfaceView extends SurfaceView{
	private ShoootSurfaceHolderCallback cb = null;
	
	public ShoootSurfaceView(Context context) {
		super(context);
		// TODO Auto-generated constructor stub
		SurfaceHolder holder = getHolder();
		cb = new ShoootSurfaceHolderCallback();
		holder.addCallback(cb);
	}
	
	@Override // SurfaceViewのサイズを取得
	protected void onSizeChanged(int w, int h, int oldw, int oldh){
		cb.vieww = w; cb.viewh = h;
	}
	
	@Override // タッチされた位置を取得
	public boolean onTouchEvent(MotionEvent event) {
		float x = event.getX(); // 座標を取得
								//float y = event.getY(); // 座標を取得
		int action = event.getAction(); // タッチの動作を取得
		cb.getTouchPosition(x, action);
		return true;
	}
}
*/