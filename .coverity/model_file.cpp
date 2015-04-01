void operator delete[]( void* p )
{
	__coverity_free__(p);
}

  void operator delete( void* p )
{
	__coverity_free__(p);
}

