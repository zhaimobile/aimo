//
//  GameWorld.mm
//  AIMO
//
//  Created by 天才翟墨 on 1/27/13.
//
//

#include "GameWorld.h"
#include "GameView.h"


GameWorld::GameWorld(int cx, int cy):
        m_cxClient(cx),
        m_cyClient(cy),
        m_bPaused(false),
        m_vCrosshair(Vector2D(200, cxClient()/2.0))
{
    //determine a random starting position
    Vector2D SpawnPos = Vector2D(cx/2.0+RandomClamped()*cx/2.0,
                                 cy/2.0+RandomClamped()*cy/2.0);

    Vehicle* pVehicle = new Vehicle(this,
                                    SpawnPos,                 //initial position
                                    RandFloat()*TwoPi,        //start rotation
                                    Vector2D(0,0),            //velocity
                                    1.0,//Prm.VehicleMass,          //mass
                                    200.0,//Prm.MaxSteeringForce,     //max force
                                    80,//Prm.MaxSpeed,             //max velocity
                                    25.0,//Prm.MaxTurnRatePerSecond, //max turn rate
                                    10.0);//Prm.VehicleScale);        //scale

    pVehicle->Steering()->ArriveOn();
    m_Vehicles.push_back(pVehicle);


//setup the agents
    for (int a=0; a< 10; ++a)
    {
        //determine a random starting position
        Vector2D SpawnPos2 = Vector2D(cx/2.0+RandomClamped()*cx/2.0,
                                      cy/2.0+RandomClamped()*cy/2.0);
        
        
        Vehicle* pVehicle2 = new Vehicle(this,
                                         SpawnPos2,                 //initial position
                                         RandFloat()*TwoPi,        //start rotation
                                         Vector2D(0,0),            //velocity
                                         1.0,//Prm.VehicleMass,          //mass
                                         200.0,//Prm.MaxSteeringForce,     //max force
                                         50,//Prm.MaxSpeed,             //max velocity
                                         5.0,//Prm.MaxTurnRatePerSecond, //max turn rate
                                         5.0);//Prm.VehicleScale);        //scale
        
        pVehicle2->Steering()->EvadeOn(pVehicle);
        m_Vehicles.push_back(pVehicle2);

    }

//
//
//#define SHOAL
//#ifdef SHOAL
//    m_Vehicles[Prm.NumAgents-1]->Steering()->FlockingOff();
//    m_Vehicles[Prm.NumAgents-1]->SetScale(Vector2D(10, 10));
//    m_Vehicles[Prm.NumAgents-1]->Steering()->WanderOn();
//    m_Vehicles[Prm.NumAgents-1]->SetMaxSpeed(70);
//    
//    
//    for (int i=0; i<Prm.NumAgents-1; ++i)
//    {
//        m_Vehicles[i]->Steering()->EvadeOn(m_Vehicles[Prm.NumAgents-1]);
//        
//    }
//#endif
    
}

//-------------------------------- dtor ----------------------------------
//------------------------------------------------------------------------
GameWorld::~GameWorld()
{
    for (unsigned int a=0; a<m_Vehicles.size(); ++a)
    {
        delete m_Vehicles[a];
    }
}


//------------------------- Set Crosshair ------------------------------------
//
//  The user can set the position of the crosshair by user-input or setting.
//  This method makes sure the click is not inside any enabled
//  Obstacles and sets the position appropriately
//------------------------------------------------------------------------
void GameWorld::SetCrosshair(Vector2D v)
{
    Vector2D ProposedPosition((double)v.x, (double)v.y);
    
    //make sure it's not inside an obstacle
//    for (ObIt curOb = m_Obstacles.begin(); curOb != m_Obstacles.end(); ++curOb)
//    {
//        if (PointInCircle((*curOb)->Pos(), (*curOb)->BRadius(), ProposedPosition))
//        {
//            return;
//        }
//    }
    
    
    m_vCrosshair.x = ProposedPosition.x;
    m_vCrosshair.y = ProposedPosition.y;
}


//----------------------------- Update -----------------------------------
//------------------------------------------------------------------------
void GameWorld::update(double time_elapsed)
{
    if (m_bPaused) return;

    //update the vehicles
    for (unsigned int a=0; a<m_Vehicles.size(); ++a)
    {
        m_Vehicles[a]->Update(time_elapsed);
        
        //Vector2D v = m_Vehicles[a]-> Pos();
        
       // printf("Time elapsed in Game:%f and Pos(%f,%f)\n",time_elapsed, v.x, v.y);
    }
}

//------------------------------ Render ----------------------------------
//------------------------------------------------------------------------
void GameWorld::render()
{
    //render the Crosshair
    UIColor *color = [UIColor purpleColor];
    [GameView drawCircleWithPosition:this->Crosshair() withSize:5 andColor:color];
    
    //render the agents
    for (unsigned int a=0; a<m_Vehicles.size(); ++a)
    {
        m_Vehicles[a]->Render();
    }
}
