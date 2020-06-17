class grad_leakage {

	class client {
		file = grad-leakage\functions\client;

		class holeFX;
		class holeSpall;
		class registerHit;
	};

	class server {
		file = grad-leakage\functions\server;

		class adjustLiquidLevelIndicator;
		class getHeightInModel;
		class holeAdd;
		class holeFix;
		class holeRegister;
		class isLeaking;
		class main {preInit = 1;};
	};
};