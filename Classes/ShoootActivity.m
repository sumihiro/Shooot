//
//  ShoootActivity.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ShoootActivity.h"


@implementation ShoootActivity

@end

/* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

import android.app.Activity;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Vibrator;

public class ShoootActivity extends Activity {
	static Bitmap bgimage;
	static Bitmap spaceship;
	static Bitmap enemy;
	static Bitmap mybullet;
	static Bitmap bullet1, bullet2;
	static Vibrator vibrator;
	
 // Called when the activity is first created. 
    @Override // Activityのライフサイクルのメソッド。生成時に呼ばれる
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);  
        // SurfaceViewを登録
        setContentView(new ShoootSurfaceView(this));
        vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);
    }
    
    @Override // Activityのライフサイクルのメソッド
    public void onResume(){
    	super.onResume();
    	// リソースから画像ファイルを読み込む
		Resources res = getResources(); // リソースの取得
		bgimage = BitmapFactory.decodeResource(res, R.drawable.earthrise);
		spaceship = BitmapFactory.decodeResource(res, R.drawable.spaceship);
		enemy = BitmapFactory.decodeResource(res, R.drawable.enemy);
		mybullet = BitmapFactory.decodeResource(res, R.drawable.mybullet);
		bullet1 = BitmapFactory.decodeResource(res, R.drawable.bullet1);
		bullet2 = BitmapFactory.decodeResource(res, R.drawable.bullet2);
    }
    
    @Override  // Activityのライフサイクルのメソッド
    public void onPause(){
    	super.onPause();
    	finish(); // onDestroy()が呼ばれる
    }
	
    @Override // Activityのライフサイクルのメソッド。終了時に呼ぶ
	public void onDestroy() {
    	super.onDestroy();
    }
}
*/