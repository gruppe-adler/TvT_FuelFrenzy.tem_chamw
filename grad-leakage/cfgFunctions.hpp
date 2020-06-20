class grad_leakage {

	class client {
		file = grad-leakage\functions\client;

		class holeFXcreate;
		class holeFXinit;
		class holeRepair;
		class holeRepairAction;
		class holeSpall;
		class holeStreamCreate;
		class puddleCreate;
		class registerHit;
	};

	class server {
		file = grad-leakage\functions\server;

		class adjustLiquidLevelIndicator;
		class getHeightInModel;
		class holeRegister;
		class isLeaking;
		class main {preInit = 1;};
	};
};
